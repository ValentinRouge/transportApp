//
//  ZoneController.swift
//  Arrêt Île-de-France
//
//  Created by Valentin Rouge on 13/10/2023.
//

import Foundation

class ZoneController {
    static let instance = ZoneController()
    
    var allZones: [Zone]
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
        
        sortZones()
    }
    
    func getAllZones() -> [Zone] {
        return allZones
    }
    
    func sortZones(){
        allZones.sort { Z1, Z2 in
            if Z1.fields.zdatown == Z2.fields.zdatown {
                return Z1.fields.zdaname < Z2.fields.zdaname
            }
            return Z1.fields.zdatown < Z2.fields.zdatown
        }
    }

    
}
