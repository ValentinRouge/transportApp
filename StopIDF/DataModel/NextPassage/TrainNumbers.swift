//
//  TrainNumbers.swift
//  Arrêt Île-de-France
//
//  Created by Valentin Rouge on 10/10/2023.
//

import Foundation

struct TrainNumbers : Codable {
    let trainNumberRef : [String]?

    enum CodingKeys: String, CodingKey {

        case trainNumberRef = "TrainNumberRef"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        trainNumberRef = try values.decodeIfPresent([String].self, forKey: .trainNumberRef)
    }

}
