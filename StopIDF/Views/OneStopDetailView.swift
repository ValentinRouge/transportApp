//
//  ContentView.swift
//  Arrêt Île-de-France
//
//  Created by Valentin Rouge on 10/10/2023.
//

import SwiftUI
import WrappingHStack
import FlowStackLayout

struct OneStopDetailView: View {
    @State var buttonEnabled = true
    @State var passagesList: [ToComeAtBusStop] = []
    let ZoneID: String
    let ZoneName: String
    
    init(ZoneID: String, ZoneName: String) {
        self.ZoneID = ZoneID
        self.ZoneName = ZoneName
    }
    
    var body: some View {
        ScrollView {
            VStack {
                VStack(alignment: .leading, spacing: 5, content: {
                    Text(ZoneName)
                        .font(.title)
                    Divider()
                        .frame(height: 0)
                    
                    if passagesList.isEmpty {
                        Text("Aucun passage prévu...")
                    } else {
                        VStack(alignment:.leading) {
                            ForEach(passagesList, id: \.id) { passage in
                                getOneLineView(passage: passage)
                            }
                        }
                    }
                })
                .padding([.all], 10)
                .background(Color(UIColor.secondarySystemBackground))
                .clipShape(
                    RoundedRectangle(cornerRadius: 16)
                )
                .onAppear(perform: {
                    updateNextPassages()
                })
                
                Button("Actualiser", action: updateNextPassages)
                    .buttonStyle(.borderedProminent)
                    .disabled(!buttonEnabled)
            }
        }

    }
    
    func updateNextPassages() {
        NextPassageController.instance.fetchNextPassage(StopID: ZoneID ,nextPassageCompletionHandler: { displayInfoNextPassage, error in
            if let nextPassages = displayInfoNextPassage {
                self.passagesList = nextPassages
            } else {
                self.passagesList = []
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
    
    func getOneLineView(passage: ToComeAtBusStop) -> AnyView {
         
        return AnyView(VStack(alignment: .leading, content: {
            LinePictoView(linePictoInfos: passage.LineInfosForPicto, lineName: passage.lineName ?? "Numéro inconnu")
            ForEach(passage.lineDirections) { direction in
                getOneDirectionView(direction: direction)
            }
        }))
    }
    
    func getOneDirectionView(direction: LineDirectionDestinations) -> AnyView {
        return AnyView(
            VStack(alignment: .leading){
                Text(direction.lineDirection ?? "Direction inconnue")
                Grid(alignment: .leading, horizontalSpacing: 8, verticalSpacing: 10, content: {
                   ForEach(direction.lineDestinationTime) { destination in
                       getOneDestinationView(destination: destination)
                   }
                })
            }
        )
    }
    
    func getOneDestinationView(destination: LineDestinationToCome) -> AnyView {
        return AnyView(GridRow {
            Text(destination.destinationName ?? "direction inconnue")
                .fixedSize(horizontal: false, vertical: true)
            if !destination.nextOnes.isEmpty {
                FlowStack(alignment: .leading, horizontalSpacing: 4, verticalSpacing: 4) {
                    
                    //On les trie au cas ou il y a tjr des cas chelou (j'ai pas réussi à le fair avant)
                    let nextOnesSorted = destination.nextOnes.sorted(by: {$0 ?? .min < $1 ?? .min})
                    
                    ForEach(nextOnesSorted, id: \.self){ temps in
                        getOneTimeView(time: temps)
                    }
                    Spacer()
                }
                .fixedSize(horizontal: false, vertical: false)
            } else {
                Text("Aucun passage prévu...")
            }
        })
    }
    
    func getOneTimeView(time: Int?) -> OneTimeView {
        return OneTimeView(time: time)
    }
}

#Preview {
    OneStopDetailView(ZoneID: "43414",ZoneName: "Général De Bollardière") //43232
}

