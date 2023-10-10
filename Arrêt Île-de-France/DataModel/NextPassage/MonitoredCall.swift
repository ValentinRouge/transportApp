//
//  MonitoredCall.swift
//  Arrêt Île-de-France
//
//  Created by Valentin Rouge on 10/10/2023.
//

import Foundation

struct MonitoredCall : Codable {
    let stopPointName : [StopPointName]?
    let vehicleAtStop : Bool?
    let destinationDisplay : [DestinationDisplay]?
    let expectedArrivalTime : String?
    let expectedDepartureTime : String?
    let departureStatus : String?
    let order : Int?
    let aimedArrivalTime : String?
    let aimedDepartureTime : String?
    let arrivalStatus : String?

    enum CodingKeys: String, CodingKey {

        case stopPointName = "StopPointName"
        case vehicleAtStop = "VehicleAtStop"
        case destinationDisplay = "DestinationDisplay"
        case expectedArrivalTime = "ExpectedArrivalTime"
        case expectedDepartureTime = "ExpectedDepartureTime"
        case departureStatus = "DepartureStatus"
        case order = "Order"
        case aimedArrivalTime = "AimedArrivalTime"
        case aimedDepartureTime = "AimedDepartureTime"
        case arrivalStatus = "ArrivalStatus"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        stopPointName = try values.decodeIfPresent([StopPointName].self, forKey: .stopPointName)
        vehicleAtStop = try values.decodeIfPresent(Bool.self, forKey: .vehicleAtStop)
        destinationDisplay = try values.decodeIfPresent([DestinationDisplay].self, forKey: .destinationDisplay)
        expectedArrivalTime = try values.decodeIfPresent(String.self, forKey: .expectedArrivalTime)
        expectedDepartureTime = try values.decodeIfPresent(String.self, forKey: .expectedDepartureTime)
        departureStatus = try values.decodeIfPresent(String.self, forKey: .departureStatus)
        order = try values.decodeIfPresent(Int.self, forKey: .order)
        aimedArrivalTime = try values.decodeIfPresent(String.self, forKey: .aimedArrivalTime)
        aimedDepartureTime = try values.decodeIfPresent(String.self, forKey: .aimedDepartureTime)
        arrivalStatus = try values.decodeIfPresent(String.self, forKey: .arrivalStatus)
    }

}
