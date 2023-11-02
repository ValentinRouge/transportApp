//
//  VersionSchemaV1.swift
//  StopIDF
//
//  Created by Valentin Rouge on 02/11/2023.
//

import Foundation
import SwiftData

enum ZoneSchemaV1: VersionedSchema {
    
    static var models: [any PersistentModel.Type] {
        [SDZones.self]
    }
    
    static var versionIdentifier: Schema.Version = .init(1,0,0)
    
    @Model
    class SDZones {
        @Attribute(.unique) let id : String
        
        let postalCode : String
        let mode : String
        let yCoordinates : Int
        let xCoordinates : Int
        let town : String
        @Attribute(.spotlight) let name : String
        
        
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

}
