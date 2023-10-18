//
//  File.swift
//  Arrêt Île-de-France
//
//  Created by Valentin Rouge on 10/10/2023.
//

import Foundation

struct NextPassage : Codable {
    let siri : Siri

    enum CodingKeys: String, CodingKey {

        case siri = "Siri"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        siri = try values.decode(Siri.self, forKey: .siri)
    }

}
