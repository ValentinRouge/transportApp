//
//  LinePictoView.swift
//  StopIDF
//
//  Created by Valentin Rouge on 18/10/2023.
//

import SwiftUI

struct LinePictoView: View {
    let linePictoInfos: LineInfosForPicto?
    let lineName: String
    
    init(linePictoInfos: LineInfosForPicto?, lineName: String) {
        self.linePictoInfos = linePictoInfos
        self.lineName = lineName
    }
    
    var body: some View {
        getPicto()
    }
    
    func getPicto() -> AnyView {
        let dividedFactor = 0.66
        
        guard let linePictoInfos = linePictoInfos else { return AnyView(Text(lineName)) }
        
        switch linePictoInfos.lineMode {
        case "rail", "tram", "cable", "metro":
            return AnyView(Image(lineName).resizable().scaledToFit().frame(width: 45*dividedFactor))
        default:
            return AnyView(
                RoundedRectangle(cornerRadius: 7.5*dividedFactor)
                            .frame(width: 100*dividedFactor, height: 45*dividedFactor)
                            .foregroundColor(Color(hex: linePictoInfos.BGColor ?? "64B5E5"))
                            .overlay(content: {
                                Text(lineName)
                                    .font(.custom("IDFVoyageur-Bold", size: 30*dividedFactor))
                                    .padding([.top],6*dividedFactor)
                                    .foregroundColor(Color(hex: linePictoInfos.FGColor ?? "fff"))
                            })
            )
        }
    }
}

#Preview {
    LinePictoView(linePictoInfos: LineInfosForPicto(lineMode: "bus", BGColor: nil, FGColor: nil), lineName: "B")
}
