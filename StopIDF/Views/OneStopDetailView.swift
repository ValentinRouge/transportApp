//
//  ContentView.swift
//  Arrêt Île-de-France
//
//  Created by Valentin Rouge on 10/10/2023.
//

import SwiftUI
import SwiftData
import WrappingHStack
import FlowStackLayout

struct OneStopDetailView: View {
    @State var buttonEnabled = true
    @State var buttonAnimation = false
    @State var passagesList: [ToComeAtBusStop] = []
    @State var APIerror: ApiRequestError?
    @State var Stop: SDZones
    
    init(Zone: SDZones) {
        self.Stop = Zone
    }
    
    var body: some View {
        ScrollView {
            VStack {
                VStack(alignment: .leading, spacing: 5, content: {
                    HStack(spacing: 15) {
                        Text(Stop.name)
                            .font(.title)
                        
                        Spacer()
                        
                        Button() {
                            withAnimation {
                                updateNextPassages()
                                self.buttonAnimation.toggle()
                            }
                        } label: {
                            Image(systemName: "arrow.clockwise")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 25)
                                .rotationEffect(.degrees(self.buttonAnimation ? 360 : 0))
                        }
                            .disabled(!buttonEnabled)
                        
                        Button() {
                            Stop.isFavorite.toggle()
                        } label: {
                            Stop.isFavorite ? Image(systemName: "star.slash.fill").resizable().frame(width: 25,height: 25) : Image(systemName: "star").resizable().frame(width: 25,height: 25)
                        }

                    }
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

            }
        }
    }
    
    func updateNextPassages() {
        NextPassageController.instance.fetchNextPassage(StopID: Stop.id ,nextPassageCompletionHandler: { displayInfoNextPassage, error in
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
            buttonAnimation.toggle()
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
    MainActor.assumeIsolated {
        OneStopDetailView(Zone: PreviewZoneData.previewZone) // 43414 43238
            .modelContainer(PreviewZoneData.container)
    }
    
}

