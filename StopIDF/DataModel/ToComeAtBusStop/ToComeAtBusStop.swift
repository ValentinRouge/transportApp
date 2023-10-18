//
//  File.swift
//  Arrêt Île-de-France
//
//  Created by Valentin Rouge on 10/10/2023.
//

import Foundation

struct ToComeAtBusStop: Equatable, Identifiable {
    let id: UUID = UUID()
    let lineName : String?
    let lineRef: String?
    let lineDirection: String?
    let destinationName: String?
    var nextOnes : [Int?]
}

