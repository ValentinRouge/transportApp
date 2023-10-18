//
//  NextPassageController.swift
//  Arrêt Île-de-France
//
//  Created by Valentin Rouge on 12/10/2023.
//

import Foundation

class NextPassageController {
    static let instance = NextPassageController()
    
    let endpoint = "https://prim.iledefrance-mobilites.fr/marketplace/stop-monitoring?MonitoringRef=STIF:StopPoint:Q:" // 43232: 52849
    var allLines: [LineReferencial]
    let decoder = JSONDecoder()
    
    private init(){
        let data:Data? = LocalDataManager.instance.getTransportLineData()
        
        if let unvrappedData = data {
            do {
                allLines = try self.decoder.decode([LineReferencial].self, from: unvrappedData)
            } catch {
                allLines = []
            }
        } else {
            allLines = []
        }
        
    }
    
    func fetchNextPassage(StopID: String ,nextPassageCompletionHandler: @escaping ([ToComeAtBusStop]?, Error?) -> Void) {
        let completeEndpoint = endpoint + StopID + ":"
        
        guard let url = URL(string: completeEndpoint) else {
            return nextPassageCompletionHandler(nil, ApiRequestError.invalidURL)
        }
        
        var request = URLRequest(url: url)
        request.setValue(EnvVariables.PRIM_API_KEY, forHTTPHeaderField: "apiKey")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            //print(String(data: data!, encoding: .utf8)!)

            guard let testResponse = response as? HTTPURLResponse, testResponse.statusCode == 200 else {
                return nextPassageCompletionHandler(nil, ApiRequestError.httpError(response))
            }
            
            guard let unvrappedData = data else {
                return nextPassageCompletionHandler(nil, ApiRequestError.nothingReturned)
            }
            
            
            do {
                let dataJSON:NextPassage = try self.decoder.decode(NextPassage.self, from: unvrappedData)
                nextPassageCompletionHandler(self.extratToCome(nextPassage: dataJSON), nil)
            } catch {
                print(error)
                nextPassageCompletionHandler(nil,ApiRequestError.failDecoding)
            }
        }.resume()
    }
    
    func extratToCome(nextPassage: NextPassage) -> [ToComeAtBusStop]{
        print(nextPassage)
        var listOfIncoming:[ToComeAtBusStop] = []
        
        for stop in nextPassage.siri.serviceDelivery.stopMonitoringDelivery {
            if let visits = stop.monitoredStopVisit {
                for visit in visits {
                    //print(visit)
                    if let lineAlreadyComing = checkIfLineAlreadyComing(visit: visit, listOfIncoming: listOfIncoming) {
                        let lineIncomingIndex = listOfIncoming.firstIndex(where: {$0 == lineAlreadyComing})
                        if let unwrappedLineIncomingIndex = lineIncomingIndex {
                        // la je sais que le bus viens je vais chercher si le sens est déjà là
                            if let directionAlreadyComing = checkIfDirectionAlreadyComing(visit: visit, listOfIncoming: listOfIncoming[unwrappedLineIncomingIndex].lineDirections) {
                                let lineDirectionIndex = listOfIncoming[unwrappedLineIncomingIndex].lineDirections.firstIndex(where: {$0 == directionAlreadyComing})
                                if let unwrappedLineDirectionIndex = lineDirectionIndex{
                                    if let destinationAlreadyComing = checkIfDestinationAlreadyComing(visit: visit, listOfIncoming: listOfIncoming[unwrappedLineIncomingIndex].lineDirections[unwrappedLineDirectionIndex].lineDestinationTime) {
                                        let lineDestinationIndex = listOfIncoming[unwrappedLineIncomingIndex].lineDirections[unwrappedLineDirectionIndex].lineDestinationTime.firstIndex(where: {$0 == destinationAlreadyComing})
                                        if let unwrappedLineDestinationIndex = lineDestinationIndex{
                                            listOfIncoming[unwrappedLineIncomingIndex].lineDirections[unwrappedLineDirectionIndex].lineDestinationTime[unwrappedLineDestinationIndex].nextOnes.append(calculateTimeInterval(comingTime: getComingTime(visit: visit)))
                                        } else {
                                            listOfIncoming[unwrappedLineIncomingIndex].lineDirections[unwrappedLineDirectionIndex].lineDestinationTime.append(addNewDestinationToDirectionIncoming(visit: visit))                                        }
                                    } else {
                                        listOfIncoming[unwrappedLineIncomingIndex].lineDirections[unwrappedLineDirectionIndex].lineDestinationTime.append(addNewDestinationToDirectionIncoming(visit: visit))
                                    }
                                } else {
                                    listOfIncoming[unwrappedLineIncomingIndex].lineDirections.append(addNewDirectionToLineIncoming(visit: visit))
                                }
                            } else {
                                listOfIncoming[unwrappedLineIncomingIndex].lineDirections.append(addNewDirectionToLineIncoming(visit: visit))
                            }
                        } else {
                            listOfIncoming.append(addNewLineToListOfIncoming(visit: visit))
                        }
                    } else {
                        listOfIncoming.append(addNewLineToListOfIncoming(visit: visit))
                    }
                }
            }
        }
        
        return listOfIncoming
        
    }
    
    func calculateTimeInterval(comingTime: String?) -> Int? {
        let dateFormater = ISO8601DateFormatter()
        dateFormater.formatOptions = [.withFractionalSeconds, .withInternetDateTime]
        
        guard let unvrappedComingTime = comingTime else {
            return nil
        }
        
        let date = dateFormater.date(from: unvrappedComingTime)
        
        if let unvrappedDate = date {
            let timeInterval = (unvrappedDate.timeIntervalSinceNow)
            return (Int(round((timeInterval)/60)))
        } else {
            return nil
        }

    }
    
    func getLineName(id:String?) -> String? {
        guard var unwrappedID = id else {
            return id
        }
        
        let start = unwrappedID.index(unwrappedID.startIndex, offsetBy: 11)
        let end = unwrappedID.index(unwrappedID.endIndex, offsetBy: -1)
        let range = start..<end

        unwrappedID = String(unwrappedID[range])
        
        //print(unwrappedID)
        let line = allLines.filter{$0.fields.id_line.contains(unwrappedID)}
        //print(line)
        
        if line.isEmpty || line.count > 1{
            return id
        } else {
            if let lineName = line[0].fields.shortname_line {
                return lineName
            } else {
                return line[0].fields.name_line
            }
        }
    }
    
    func checkIfLineAlreadyComing(visit: MonitoredStopVisit, listOfIncoming: [ToComeAtBusStop]) -> ToComeAtBusStop? {
        if listOfIncoming.count == 0{
            return nil
        }
        
        for incoming in listOfIncoming {
            if (incoming.lineRef == visit.monitoredVehicleJourney?.lineRef?.value) {
                return incoming
            }
        }
        
        return nil
        
    }
    
    
    func checkIfDirectionAlreadyComing(visit: MonitoredStopVisit, listOfIncoming: [LineDirectionDestinations]) -> LineDirectionDestinations? {
        if listOfIncoming.count == 0{
            return nil
        }
        
        for incoming in listOfIncoming {
            if (incoming.lineDirection == visit.monitoredVehicleJourney?.directionName?[0].value) {
                return incoming
            }
        }
        
        return nil
        
    }
    
    func checkIfDestinationAlreadyComing(visit: MonitoredStopVisit, listOfIncoming: [LineDestinationToCome]) -> LineDestinationToCome? {
        if listOfIncoming.count == 0{
            return nil
        }
        
        for incoming in listOfIncoming {
            if (incoming.destinationName == visit.monitoredVehicleJourney?.destinationName?[0].value) {
                return incoming
            }
        }
        
        return nil
        
    }
    
    func addNewLineToListOfIncoming(visit: MonitoredStopVisit) -> ToComeAtBusStop{
        let lineDestination: LineDestinationToCome = LineDestinationToCome(destinationName: visit.monitoredVehicleJourney?.destinationName?[0].value,
                                                                           nextOnes: [calculateTimeInterval(comingTime: getComingTime(visit: visit))])
        
        let lineDirection: LineDirectionDestinations = LineDirectionDestinations(lineDirection: visit.monitoredVehicleJourney?.directionName?[0].value, lineDestinationTime: [lineDestination])
        
        return ToComeAtBusStop(lineName: getLineName(id: visit.monitoredVehicleJourney?.lineRef?.value),
                               lineRef: visit.monitoredVehicleJourney?.lineRef?.value, lineDirections: [lineDirection])
    }
    
    func addNewDirectionToLineIncoming(visit: MonitoredStopVisit) -> LineDirectionDestinations{
        let lineDestination: LineDestinationToCome = LineDestinationToCome(destinationName: visit.monitoredVehicleJourney?.destinationName?[0].value,
                                                                           nextOnes: [calculateTimeInterval(comingTime: getComingTime(visit: visit))])
        
        return LineDirectionDestinations(lineDirection: visit.monitoredVehicleJourney?.directionName?[0].value, lineDestinationTime: [lineDestination])
    }
    
    func addNewDestinationToDirectionIncoming(visit: MonitoredStopVisit) -> LineDestinationToCome{
        return LineDestinationToCome(destinationName: visit.monitoredVehicleJourney?.destinationName?[0].value,
                                                             nextOnes: [calculateTimeInterval(comingTime: getComingTime(visit: visit))])
    }
    
    func getComingTime(visit: MonitoredStopVisit) -> String?{
        if let time = visit.monitoredVehicleJourney?.monitoredCall?.expectedArrivalTime {
            return time
        } else {
            return visit.monitoredVehicleJourney?.monitoredCall?.expectedDepartureTime
        }
    }
    
}