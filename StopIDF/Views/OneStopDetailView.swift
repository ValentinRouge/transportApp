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
                        VStack{
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
         
        return AnyView(VStack(content: {
            Text(passage.lineName ?? "Numéro iconnu")
                .font(Font.title3.weight(.semibold))
                .gridColumnAlignment(.trailing)
            
            ForEach(passage.lineDirections) { direction in
                getOneDirectionView(direction: direction)
            }
        }))
    }
    
    func getOneDirectionView(direction: LineDirectionDestinations) -> AnyView {
        return AnyView(
            VStack{
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
                    ForEach(destination.nextOnes, id: \.self){ temps in
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
    
    func getOneTimeView(time: Int?) -> AnyView {
        var tousTemps: String
        if let realTime = time {
            if realTime <= 0 {
                tousTemps = "<1 min"
            } else {
                tousTemps = "\(realTime) min"
            }
        } else {
            tousTemps = "NA"
        }
        
        return AnyView(Text(tousTemps)
            .padding([.horizontal], 5)
            .padding([.vertical], 2)
            .foregroundStyle(Color.white)
            .background(Color(.green))
            .clipShape(RoundedRectangle(cornerSize: /*@START_MENU_TOKEN@*/CGSize(width: 20, height: 10)/*@END_MENU_TOKEN@*/, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
        )
    }
}

#Preview {
    OneStopDetailView(ZoneID: "43414",ZoneName: "Général De Bollardière") //43232
}

