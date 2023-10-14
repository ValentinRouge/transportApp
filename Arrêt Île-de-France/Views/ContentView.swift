//
//  ContentView.swift
//  Arrêt Île-de-France
//
//  Created by Valentin Rouge on 10/10/2023.
//

import SwiftUI

struct ContentView: View {
    @State var nextPassage:String = "Hello world"
    @State var buttonEnabled = true
    let ZoneID: String
    
    init(ZoneID: String) {
        self.ZoneID = ZoneID
    }
    
    var body: some View {
        VStack {
            Text(nextPassage)
            Button("Actualiser", action: updateNextPassages)
                .buttonStyle(.borderedProminent)
                .disabled(!buttonEnabled)
        }
        .padding()
        .onAppear(perform: {
            updateNextPassages()
        })
    }
    
    func updateNextPassages() {
        NextPassageController.instance.fetchNextPassage(StopID: ZoneID ,nextPassageCompletionHandler: { displayInfoNextPassage, error in
            if let nextPassages = displayInfoNextPassage {
                var displayString = ""
                for passage in nextPassages {
                    var tousTemps:String = ""
                    for temps in passage.nextOnes {
                        if let realTime = temps {
                            if realTime <= 0 {
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
        buttonEnabled.toggle()
        DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
            buttonEnabled.toggle()
        }
    }
    
    func enableButton(){
        buttonEnabled.toggle()
    }
}

#Preview {
    ContentView(ZoneID: "43232")
}
