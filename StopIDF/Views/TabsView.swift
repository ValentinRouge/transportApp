//
//  TabView.swift
//  Arrêt Île-de-France
//
//  Created by Valentin Rouge on 13/10/2023.
//

import SwiftUI

struct TabsView: View {
    var body: some View {
        TabView{
            OneStopDetailView(ZoneID: "43164",ZoneName: "Favoris")
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
