//
//  LineDirectionDestinations.swift
//  StopIDF
//
//  Created by Valentin Rouge on 18/10/2023.
//

import Foundation

struct LineDirectionDestinations : Equatable, Identifiable {
    let id: UUID = UUID()
    let lineDirection: String?
    var lineDestinationTime : [LineDestinationToCome]
}
