//
//  ZoneController.swift
//  Arrêt Île-de-France
//
//  Created by Valentin Rouge on 13/10/2023.
//

import Foundation
import SwiftData

class ZoneController {
    
    static let instance = ZoneController()
    
    var allZones: [Zone]
    var allSDZones: [SDZones] = []
    let decoder = JSONDecoder()
    
    private init(){
        let data:Data? = LocalDataManager.instance.getAllZoneData()
        
        if let unvrappedData = data {
            do {
                allZones = try self.decoder.decode([Zone].self, from: unvrappedData)
            } catch {
                allZones = []
            }
        } else {
            allZones = []
        }
    }
    
    func createSDZone(zone: Zone) -> SDZones {
        let (lat, long) = GeographicUtils.convertLambert93ToWGS84(x: Double(zone.fields.zdaxepsg2154), y: Double(zone.fields.zdayepsg2154))
        return SDZones(id: zone.fields.zdaid, postalCode: zone.fields.zdapostalregion, mode: zone.fields.zdatype, latitude: lat, longitude: long, town: zone.fields.zdatown, name: zone.fields.zdaname)
    }
    
    func compilateSDZones() {
        for zone in allZones {
            allSDZones.append(createSDZone(zone: zone))
        }
    }
    
    func getAllZones() -> [SDZones] {
        compilateSDZones()
        return allSDZones
    }

    
}
