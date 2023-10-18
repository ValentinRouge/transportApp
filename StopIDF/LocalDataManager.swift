//
//  LocalDataManager.swift
//  Arrêt Île-de-France
//
//  Created by Valentin Rouge on 13/10/2023.
//

import Foundation

class LocalDataManager {
    static let instance = LocalDataManager()
    
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
    
    func getTransportLineData() -> Data? {
        readLocalFile(forName: "TransportLines")
    }
    
    func getAllZoneData() -> Data? {
        readLocalFile(forName: "BusStopZones")
    }
}
