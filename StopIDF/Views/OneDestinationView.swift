//
//  OneDestinationView.swift
//  StopIDF
//
//  Created by Valentin Rouge on 21/10/2023.
//

import SwiftUI
import FlowStackLayout

struct OneDestinationView: View {
    let destination: LineDestinationToCome
    
    init(destination: LineDestinationToCome) {
        self.destination = destination
    }
    
    var body: some View {
        GridRow {
            Text(destination.destinationName ?? "direction inconnue")
                .fixedSize(horizontal: false, vertical: true)
            if !destination.nextOnes.isEmpty {
                FlowStack(alignment: .leading, horizontalSpacing: 4, verticalSpacing: 4) {
                    
                    //On les trie au cas ou il y a tjr des cas chelou (j'ai pas réussi à le fair avant)
                    let nextOnesSorted = destination.nextOnes.sorted(by: {$0 ?? .min < $1 ?? .min})
                    
                    ForEach(nextOnesSorted, id: \.self){ temps in
                        OneTimeView(time: temps)
                    }
                    Spacer()
                }
                .fixedSize(horizontal: false, vertical: false)
            } else {
                Text("Aucun passage prévu...")
            }
        }
    }
}

#Preview {
    OneDestinationView(destination: LineDestinationToCome(destinationName: "Paris CDG", nextOnes: [1, 30, 65, 90]))
}
