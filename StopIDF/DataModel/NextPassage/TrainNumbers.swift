//
//  TrainNumbers.swift
//  Arrêt Île-de-France
//
//  Created by Valentin Rouge on 10/10/2023.
//

import Foundation

struct TrainNumbers : Codable {
    let trainNumberRef : [TrainNumbersRef]?

    enum CodingKeys: String, CodingKey {

        case trainNumberRef = "TrainNumberRef"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        trainNumberRef = try values.decodeIfPresent([TrainNumbersRef].self, forKey: .trainNumberRef)
    }

}
