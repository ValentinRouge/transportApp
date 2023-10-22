//
//  File.swift
//  StopIDF
//
//  Created by Valentin Rouge on 21/10/2023.
//

import Foundation
import SwiftData

@Model
class SDZones {
    @Attribute(.unique) let id : String
    
    let postalCode : String
    let mode : String
    let yCoordinates : Int
    let xCoordinates : Int
    let town : String
    let name : String


    init(id: String, postalCode: String, mode: String, yCoordinates: Int, xCoordinates: Int, town: String, name: String) {
        self.id = id
        self.postalCode = postalCode
        self.mode = mode
        self.yCoordinates = yCoordinates
        self.xCoordinates = xCoordinates
        self.town = town
        self.name = name
    }

}
