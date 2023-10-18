//
//  MonitoredVehicleJourney.swift
//  Arrêt Île-de-France
//
//  Created by Valentin Rouge on 10/10/2023.
//

import Foundation

struct MonitoredVehicleJourney : Codable {
    let lineRef : LineRef?
    let operatorRef : OperatorRef?
    let framedVehicleJourneyRef : FramedVehicleJourneyRef?
    let directionName : [DirectionName]?
    let destinationRef : DestinationRef?
    let destinationName : [DestinationName]?
    let vehicleJourneyName : [VehicleJourneyName]?
    let journeyNote : [JourneyNote]?
    let monitoredCall : MonitoredCall?
    let trainNumbers : TrainNumbers?

    enum CodingKeys: String, CodingKey {

        case lineRef = "LineRef"
        case operatorRef = "OperatorRef"
        case framedVehicleJourneyRef = "FramedVehicleJourneyRef"
        case directionName = "DirectionName"
        case destinationRef = "DestinationRef"
        case destinationName = "DestinationName"
        case vehicleJourneyName = "VehicleJourneyName"
        case journeyNote = "JourneyNote"
        case monitoredCall = "MonitoredCall"
        case trainNumbers = "TrainNumbers"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        lineRef = try values.decodeIfPresent(LineRef.self, forKey: .lineRef)
        operatorRef = try values.decodeIfPresent(OperatorRef.self, forKey: .operatorRef)
        framedVehicleJourneyRef = try values.decodeIfPresent(FramedVehicleJourneyRef.self, forKey: .framedVehicleJourneyRef)
        directionName = try values.decodeIfPresent([DirectionName].self, forKey: .directionName)
        destinationRef = try values.decodeIfPresent(DestinationRef.self, forKey: .destinationRef)
        destinationName = try values.decodeIfPresent([DestinationName].self, forKey: .destinationName)
        vehicleJourneyName = try values.decodeIfPresent([VehicleJourneyName].self, forKey: .vehicleJourneyName)
        journeyNote = try values.decodeIfPresent([JourneyNote].self, forKey: .journeyNote)
        monitoredCall = try values.decodeIfPresent(MonitoredCall.self, forKey: .monitoredCall)
        trainNumbers = try values.decodeIfPresent(TrainNumbers.self, forKey: .trainNumbers)
    }

}
