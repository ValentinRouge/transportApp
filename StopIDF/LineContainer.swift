//
//  LineContainer.swift
//  StopIDF
//
//  Created by Valentin Rouge on 25/10/2023.
//

import Foundation
import SwiftData

actor LineContainer {
    
    @MainActor
    static func create(lastUpdateDate: inout Date) -> ModelContainer {
        let schema = Schema([SDZones.self])
        let configuration = ModelConfiguration()
        do {
            let container = try ModelContainer(for: schema, configurations: configuration)
            
            if lastUpdateDate.timeIntervalSinceNow < -604800 { 
                let allSDZones = ZoneController.instance.getAllZones()
                try container.mainContext.delete(model: SDZones.self)
                for zone in allSDZones {
                    container.mainContext.insert(zone)
                }
                lastUpdateDate = Date.now
            }
            return container
        } catch {
            fatalError("Impossible to create Swift Data")
        }
    }
}
