//
//  OneDirectionView.swift
//  StopIDF
//
//  Created by Valentin Rouge on 21/10/2023.
//

import SwiftUI

struct OneDirectionView: View {
    let direction : LineDirectionDestinations
    
    init(direction: LineDirectionDestinations) {
        self.direction = direction
    }
    
    var body: some View {
        VStack(alignment: .leading){
            if !(direction.lineDestinationTime.count == 1 && direction.lineDestinationTime.first?.destinationName?.isEqualIgnoringCaseDiacriticsAndHyphen(direction.lineDirection ?? "") ?? false) {
                HStack {
                    LabelledDividerView(label: direction.lineDirection ?? "Direction inconnue", horizontalPadding: 0)
                }
                
            }
            Grid(alignment: .leading, horizontalSpacing: 8, verticalSpacing: 10, content: {
               ForEach(direction.lineDestinationTime) { destination in
                   OneDestinationView(destination: destination)
               }
            })
        }
    }
}

#Preview {
    OneDirectionView(direction: LineDirectionDestinations(lineDirection: "Paris", lineDestinationTime: [LineDestinationToCome(destinationName: "Etoile", nextOnes: [1, 30, 65, 90]), LineDestinationToCome(destinationName: "Montparnasse", nextOnes: [1, 30, 65, 90])]))
}
