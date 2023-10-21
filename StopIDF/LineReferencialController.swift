//
//  LineInfosController.swift
//  StopIDF
//
//  Created by Valentin Rouge on 21/10/2023.
//

import Foundation

class LineReferencialController {
    static let instance = LineReferencialController()
    
    let decoder = JSONDecoder()
    
    var allLines: [LineReferencial]

    init() {
        let data:Data? = LocalDataManager.instance.getTransportLineData()
        
        if let unvrappedData = data {
            do {
                allLines = try self.decoder.decode([LineReferencial].self, from: unvrappedData)
            } catch {
                allLines = []
            }
        } else {
            allLines = []
        }
    }
    
    func getLineNameAndPicto(id:String?) -> (String?, LineInfosForPicto?) {
        guard var unwrappedID = id else {
            return (id, nil)
        }
        
        let start = unwrappedID.index(unwrappedID.startIndex, offsetBy: 11)
        let end = unwrappedID.index(unwrappedID.endIndex, offsetBy: -1)
        let range = start..<end

        unwrappedID = String(unwrappedID[range])
        
        //print(unwrappedID)
        let line = allLines.filter{$0.fields.id_line.contains(unwrappedID)}
        //print(line)
        
        if line.isEmpty || line.count > 1{
            return (id, nil)
        } else {
            let lineFields = line[0].fields
            let lineMode:String?
            
            if lineFields.networkname == "Noctilien"{
                lineMode = "Noctilien"
            } else {
                lineMode = lineFields.transportmode
            }
                        
            let lineInfosForPicto = LineInfosForPicto(lineMode: lineMode, BGColor: lineFields.colourweb_hexa, FGColor: lineFields.textcolourweb_hexa)
            
            if let lineName = lineFields.shortname_line {
                return (lineName, lineInfosForPicto)
            } else {
                return (lineFields.name_line, lineInfosForPicto)
            }
        }
    }

    
}
