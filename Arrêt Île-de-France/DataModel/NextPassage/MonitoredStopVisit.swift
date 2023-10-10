//
//  MonitoredStopVisit.swift
//  Arrêt Île-de-France
//
//  Created by Valentin Rouge on 10/10/2023.
//

import Foundation
struct MonitoredStopVisit : Codable {
    let recordedAtTime : String?
    let itemIdentifier : String?
    let monitoringRef : MonitoringRef?
    let monitoredVehicleJourney : MonitoredVehicleJourney?

    enum CodingKeys: String, CodingKey {

        case recordedAtTime = "RecordedAtTime"
        case itemIdentifier = "ItemIdentifier"
        case monitoringRef = "MonitoringRef"
        case monitoredVehicleJourney = "MonitoredVehicleJourney"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        recordedAtTime = try values.decodeIfPresent(String.self, forKey: .recordedAtTime)
        itemIdentifier = try values.decodeIfPresent(String.self, forKey: .itemIdentifier)
        monitoringRef = try values.decodeIfPresent(MonitoringRef.self, forKey: .monitoringRef)
        monitoredVehicleJourney = try values.decodeIfPresent(MonitoredVehicleJourney.self, forKey: .monitoredVehicleJourney)
    }

}
