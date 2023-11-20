//
//  ZoneSchemaV3.swift
//  StopIDF
//
//  Created by Valentin Rouge on 05/11/2023.
//

import Foundation
import SwiftData

enum ZoneSchemaV3: VersionedSchema {
    
    static var models: [any PersistentModel.Type] {
        [SDZones.self]
    }
    
    static var versionIdentifier: Schema.Version = .init(1,2,0)
    
    @Model
    class SDZones {
        @Attribute(.unique) let id : String
        
        let postalCode : String
        let mode : String
        @Attribute(originalName: "yCoordinates") var latitude : Double
        @Attribute(originalName: "xCoordinates") var longitude : Double
        let town : String
        @Attribute(.spotlight) let name : String
        var isFavorite: Bool
        
        
        init(id: String, postalCode: String, mode: String, latitude: Double, longitude: Double, town: String, name: String) {
            self.id = id
            self.postalCode = postalCode
            self.mode = mode
            self.latitude = latitude
            self.longitude = longitude
            self.town = town
            self.name = name
            self.isFavorite = false
        }
    }
}
