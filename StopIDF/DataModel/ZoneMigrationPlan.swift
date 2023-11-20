//
//  ZoneMigrationPlan.swift
//  StopIDF
//
//  Created by Valentin Rouge on 02/11/2023.
//

import Foundation
import SwiftData

enum ZoneMigrationPlan: SchemaMigrationPlan {
    static var schemas: [VersionedSchema.Type] {
        [ZoneSchemaV1.self, ZoneSchemaV2.self, ZoneSchemaV3.self]
    }
    
    static var stages: [MigrationStage] {
        [migrateV1toV2]
    }
    
    static let migrateV1toV2 = MigrationStage.custom(fromVersion: ZoneSchemaV1.self, 
                                                     toVersion: ZoneSchemaV2.self,
                                                     willMigrate: nil, 
                                                     didMigrate: { context in
        let items = try? context.fetch(FetchDescriptor<ZoneSchemaV2.SDZones>())
        
        print("here")
        items?.forEach { item in
            print("migration")
            item.isFavorite = false
        }
        
        try? context.save()
    })
    
    static let migrateV2toV3 = MigrationStage.custom(fromVersion: ZoneSchemaV2.self,
                                                     toVersion: ZoneSchemaV3.self,
                                                     willMigrate: nil,
                                                     didMigrate: { context in
                                                            
        let items = try? context.fetch(FetchDescriptor<ZoneSchemaV3.SDZones>())
        print("here")
        items?.forEach { item in
            (item.latitude, item.longitude) = GeographicUtils.convertLambert93ToWGS84(x: Double(item.longitude), y: Double(item.latitude))
        }
        
        try? context.save()
        
    })

    
    
}
