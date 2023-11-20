//
//  PreviewZoneData.swift
//  StopIDF
//
//  Created by Valentin Rouge on 02/11/2023.
//

import Foundation
import SwiftData

actor PreviewZoneData {
    @MainActor
    static var container: ModelContainer = {
        do {
            let container = try ModelContainer(for: SDZones.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
            
            let zone = SDZones(id: "43412", postalCode: "12", mode: "rail", latitude: 12, longitude: 12, town: "Paris", name: "Test")
            zone.isFavorite = true
            
            container.mainContext.insert(zone)
            return container
        } catch {
            fatalError("Erreur preview container")
        }
    }()

    @MainActor
    static var previewZone: SDZones = {

        let container = PreviewZoneData.container

        let zone = SDZones(id: "43412", postalCode: "12", mode: "rail", latitude: 12, longitude: 12, town: "Paris", name: "Test")
        zone.isFavorite = true
        
        container.mainContext.insert(zone)

        return zone
    }()
}

