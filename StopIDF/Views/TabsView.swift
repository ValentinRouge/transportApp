//
//  TabView.swift
//  Arrêt Île-de-France
//
//  Created by Valentin Rouge on 13/10/2023.
//

import SwiftUI
import SwiftData

struct TabsView: View {
    @Environment(\.modelContext) var context
    @Query var datas: [SDZones]
    
    var body: some View {
        TabView{
            OneStopDetailView(Zone: SDZones(id: "43164", postalCode: "1111", mode: "rail", yCoordinates: 12, xCoordinates: 12, town: "Paris", name: "Favoris"))
                .tabItem {
                    Label("Favoris", systemImage: "star")
                }
             
            AllZoneView()
                .tabItem {
                    Label("Tout", systemImage: "list.bullet")
                }
        }
    }
}

#Preview {
    TabsView()
}
