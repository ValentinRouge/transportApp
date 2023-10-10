//
//  StopMonitoringDelivery.swift
//  Arrêt Île-de-France
//
//  Created by Valentin Rouge on 10/10/2023.
//

import Foundation
struct StopMonitoringDelivery : Codable {
    let responseTimestamp : String
    let version : String
    let status : String
    let monitoredStopVisit : [MonitoredStopVisit]?

    enum CodingKeys: String, CodingKey {

        case responseTimestamp = "ResponseTimestamp"
        case version = "Version"
        case status = "Status"
        case monitoredStopVisit = "MonitoredStopVisit"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        responseTimestamp = try values.decode(String.self, forKey: .responseTimestamp)
        version = try values.decode(String.self, forKey: .version)
        status = try values.decode(String.self, forKey: .status)
        monitoredStopVisit = try values.decodeIfPresent([MonitoredStopVisit].self, forKey: .monitoredStopVisit)
    }

}
