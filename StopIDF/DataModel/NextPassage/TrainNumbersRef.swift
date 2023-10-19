//
//  TrainNumbersRef.swift
//  StopIDF
//
//  Created by Valentin Rouge on 19/10/2023.
//

import Foundation

struct TrainNumbersRef : Codable {
    let value : String?

    enum CodingKeys: String, CodingKey {

        case value = "value"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        value = try values.decodeIfPresent(String.self, forKey: .value)
    }

}
