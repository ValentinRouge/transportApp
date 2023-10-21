//
//  LabeledDivider.swift
//  StopIDF
//
//  Created by Valentin Rouge on 20/10/2023.
//

import Foundation
import SwiftUI

struct LabelledDividerView: View {

    let label: String
    let horizontalPadding: CGFloat
    let color: Color

    init(label: String, horizontalPadding: CGFloat = 20, color: Color = .gray) {
        self.label = label
        self.horizontalPadding = horizontalPadding
        self.color = color
    }
    
    // TODO: gérer mieux -> auj c'est moche quand il y a deux lignes
    var body: some View {
        HStack() {
            Text(label).foregroundColor(color).font(.caption2).frame(maxWidth: UIScreen.screenWidth*0.95).fixedSize().padding(horizontalPadding)
            line
        }
    }

    var line: some View {
        VStack { Divider().background(color) }.padding(horizontalPadding)
    }
}

#Preview {
    LabelledDividerView(label: "sdfghj", horizontalPadding: 0)
}
