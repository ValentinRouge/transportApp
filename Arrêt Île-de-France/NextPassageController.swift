//
//  NextPassageController.swift
//  Arrêt Île-de-France
//
//  Created by Valentin Rouge on 12/10/2023.
//

import Foundation

class NextPassageController {
    static let endpoint = "https://prim.iledefrance-mobilites.fr/marketplace/stop-monitoring?MonitoringRef=STIF:StopPoint:Q:11413:"
    
    static func fetchNextPassage(nextPassageCompletionHandler: @escaping ([ToComeAtBusStop]?, Error?) -> Void) {
        let decoder = JSONDecoder()

        guard let url = URL(string: endpoint) else {
            return nextPassageCompletionHandler(nil, ApiRequestError.invalidURL)
        }
        
        var request = URLRequest(url: url)
        request.setValue("ULp2ncMDjirKGAKxymCtSyU93nX244Jn", forHTTPHeaderField: "apiKey")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            print(response!)
            print(String(data: data!, encoding: .utf8)!)

            guard let testResponse = response as? HTTPURLResponse, testResponse.statusCode == 200 else {
                return nextPassageCompletionHandler(nil, ApiRequestError.httpError(response))
            }
            
            guard let unvrappedData = data else {
                return nextPassageCompletionHandler(nil, ApiRequestError.nothingReturned)
            }
            
            
            do {
                let dataJSON:NextPassage = try decoder.decode(NextPassage.self, from: unvrappedData)
                nextPassageCompletionHandler(extratToCome(nextPassage: dataJSON), nil)
            } catch {
                nextPassageCompletionHandler(nil,ApiRequestError.failDecoding)
            }
        }.resume()
    }
    
    static func extratToCome(nextPassage: NextPassage) -> [ToComeAtBusStop]{
        var listOfIncoming:[ToComeAtBusStop] = []
        
        for stop in nextPassage.siri.serviceDelivery.stopMonitoringDelivery {
            if let visits = stop.monitoredStopVisit {
                for visit in visits {
                    listOfIncoming.append(ToComeAtBusStop(lineName: visit.monitoredVehicleJourney?.lineRef?.value, lineDirection: visit.monitoredVehicleJourney?.directionName?[0].value, destinationName: visit.monitoredVehicleJourney?.destinationName?[0].value, nextOnes: [calculateTimeInterval(comingTime: visit.monitoredVehicleJourney?.monitoredCall?.expectedArrivalTime)]))
                }
            }
        }
        
        return listOfIncoming
        
    }
    
    static func calculateTimeInterval(comingTime: String?) -> Int? {
        let dateFormater = ISO8601DateFormatter()
        dateFormater.formatOptions = [.withFractionalSeconds, .withInternetDateTime]
        
        guard let unvrappedComingTime = comingTime else {
            return nil
        }
        
        var date = dateFormater.date(from: unvrappedComingTime)
        
        if let unvrappedDate = date {
            let timeInterval = (unvrappedDate.timeIntervalSinceNow)
            return (Int(round((timeInterval)/60)))
        } else {
            return nil
        }

    }

    
    
    
}

