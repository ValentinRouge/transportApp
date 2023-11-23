//
//  TransportModeSymbolView.swift
//  StopIDF
//
//  Created by Valentin Rouge on 22/11/2023.
//

import SwiftUI

struct TransportModeSymbolView: View {
    @Environment(\.colorScheme) var colorScheme
    let transportMode: String

    let factor = 1.2
    
    var body: some View {
        Image(getSymbolName())
            .resizable()
            .scaledToFit()
            .background(Color(UIColor.systemBackground))
            .frame(width: 20*factor)
    }
    
    func getSymbolName() -> String {
        var typeName = ""
        
        switch transportMode {
        case "onstreetBus":
            typeName = "symbole_bus"
        case "railStation":
            typeName = "symbole_train"
        case "cableStation":
            typeName = "symbole_cable"
        case "metroStation":
            typeName = "symbole_metro"
        case "onstreetTram":
            typeName = "symbole_tram"
        default:
            print(transportMode)
            typeName = "symbole_bus"
        }
    
        
        if colorScheme == .light {
            return typeName
         } else {
             return typeName + "_dark"
         }

    }
}

#Preview {
    TransportModeSymbolView(transportMode: "bus")
}
