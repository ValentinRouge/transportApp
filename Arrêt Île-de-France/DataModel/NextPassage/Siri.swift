//
//  Siri.swift
//  Arrêt Île-de-France
//
//  Created by Valentin Rouge on 10/10/2023.
//

import Foundation

struct Siri : Codable {
    let serviceDelivery : ServiceDelivery

    enum CodingKeys: String, CodingKey {
        case serviceDelivery = "ServiceDelivery"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        serviceDelivery = try values.decode(ServiceDelivery.self, forKey: .serviceDelivery)
    }

}
