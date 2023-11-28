//
//  MultiMarkerTransportModeView.swift
//  StopIDF
//
//  Created by Valentin Rouge on 28/11/2023.
//

import SwiftUI

struct MultiMarkerTransportModeView: View {
    @Environment(\.colorScheme) var colorScheme
    let transportMode: String

    let factor = 1.2
    
    var body: some View {
        ZStack{
            Image(getSymbolName())
                .resizable()
                .scaledToFit()
                .background(Color(UIColor.systemBackground))
                .frame(width: 16*factor)
                .padding(.top, 0)
                .padding(.trailing, 0)
            
            Image(getSymbolName())
                .resizable()
                .scaledToFit()
                .background(Color(UIColor.systemBackground))
                .frame(width: 16*factor)
                .padding(.top, 6)
                .padding(.trailing, 6)
            
            Image(getSymbolName())
                .resizable()
                .scaledToFit()
                .background(Color(UIColor.systemBackground))
                .frame(width: 16*factor)
                .padding(.top, 12)
                .padding(.trailing, 12)
            
            Image(getSymbolName())
                .resizable()
                .scaledToFit()
                .background(Color(UIColor.systemBackground))
                .frame(width: 16*factor)
                .padding(.top, 18)
                .padding(.trailing, 18)
        }
        

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
    MultiMarkerTransportModeView(transportMode: "onstreetBus")
}
