//
//  ServiceDelivery.swift
//  Arrêt Île-de-France
//
//  Created by Valentin Rouge on 10/10/2023.
//

import Foundation

struct ServiceDelivery : Codable {
    let responseTimestamp : String
    let producerRef : String
    let responseMessageIdentifier : String
    let stopMonitoringDelivery : [StopMonitoringDelivery]

    enum CodingKeys: String, CodingKey {

        case responseTimestamp = "ResponseTimestamp"
        case producerRef = "ProducerRef"
        case responseMessageIdentifier = "ResponseMessageIdentifier"
        case stopMonitoringDelivery = "StopMonitoringDelivery"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        responseTimestamp = try values.decode(String.self, forKey: .responseTimestamp)
        producerRef = try values.decode(String.self, forKey: .producerRef)
        responseMessageIdentifier = try values.decode(String.self, forKey: .responseMessageIdentifier)
        stopMonitoringDelivery = try values.decode([StopMonitoringDelivery].self, forKey: .stopMonitoringDelivery)
    }

}
