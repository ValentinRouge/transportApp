//
//  ContentView.swift
//  Arrêt Île-de-France
//
//  Created by Valentin Rouge on 10/10/2023.
//

import SwiftUI

struct ContentView: View {
    @State var nextPassage:String = "Hello world"
    
    var body: some View {
        VStack {
            Text(nextPassage)
        }
        .padding()
        .onAppear(perform: {
            NextPassageController.fetchNextPassage(nextPassageCompletionHandler: { displayInfoNextPassage, error in
                if let nextPassages = displayInfoNextPassage {
                    var displayString = ""
                    for passage in nextPassages {
                        var tousTemps:String = ""
                        for temps in passage.nextOnes {
                            if let realTime = temps {
                                if realTime == 0 {
                                    tousTemps = tousTemps + "<1 min "
                                } else {
                                    tousTemps = tousTemps + "\(realTime) min "
                                }
                            } else {
                                tousTemps = tousTemps + "NA "
                            }
                        }
                        displayString = displayString + "\(passage.lineName ?? "Numéro iconnu") \(passage.destinationName ?? "direction inconnue") \(tousTemps) \n"
                    }
                    self.nextPassage = displayString
                } else {
                    self.nextPassage = "Erreur"
                    print(error!)
                }
                
            })
        })
    }
}

#Preview {
    ContentView()
}
