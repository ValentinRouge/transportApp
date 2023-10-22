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
    @State var APIerror: ApiRequestError?
    
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
                        switch APIerror {
                        case .failDecoding:
                            Text("Erreur de décodage")
                        case .invalidURL:
                            Text("URL de requête invalide")
                        case .httpError:
                            Text("Erreur HTTP")
                        case .nothingReturned:
                            Text("Aucune réponse du serveur")
                        default:
                            Text("Aucun passage prévu...")
                        }
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
                APIerror = error
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
        //print(passage)
        return AnyView(VStack(alignment: .leading, content: {
            LinePictoView(linePictoInfos: passage.LineInfosForPicto, lineName: passage.lineName ?? "Numéro inconnu")
            ForEach(passage.lineDirections) { direction in
                OneDirectionView(direction: direction)
            }
        }))
    }
    
}

#Preview {
    OneStopDetailView(ZoneID: "43232",ZoneName: "Général De Bollardière") // 43414 43238
}

