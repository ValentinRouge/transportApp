//
//  FramedVehicleJourneyRef.swift
//  Arrêt Île-de-France
//
//  Created by Valentin Rouge on 10/10/2023.
//

import Foundation

struct FramedVehicleJourneyRef : Codable {
    let dataFrameRef : DataFrameRef?
    let datedVehicleJourneyRef : String?

    enum CodingKeys: String, CodingKey {

        case dataFrameRef = "DataFrameRef"
        case datedVehicleJourneyRef = "DatedVehicleJourneyRef"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dataFrameRef = try values.decodeIfPresent(DataFrameRef.self, forKey: .dataFrameRef)
        datedVehicleJourneyRef = try values.decodeIfPresent(String.self, forKey: .datedVehicleJourneyRef)
    }

}
