//
//  LineDestinationToCome.swift
//  StopIDF
//
//  Created by Valentin Rouge on 18/10/2023.
//

import Foundation

struct LineDestinationToCome : Equatable, Identifiable {
    let id:UUID = UUID()
    let destinationName: String?
    var nextOnes : [Int?]
}
