//
//  AllStopsView.swift
//  Arrêt Île-de-France
//
//  Created by Valentin Rouge on 13/10/2023.
//

import SwiftUI
import SwiftData

struct AllZoneView: View {
    @Environment(\.modelContext) var context
    @Query(sort: [SortDescriptor(\SDZones.town, order: .forward), SortDescriptor(\SDZones.name, order: .forward)]
    ) var allZones: [SDZones]
    @State private var searchText = ""
    
    var searchResults: [SDZones] {
        if searchText.isEmpty {
            return allZones
        } else {
            return allZones.filter{$0.name.localizedCaseInsensitiveContains(searchText)}
        }
    }
    
    var body: some View {
        NavigationStack {
            List(searchResults, id: \.id){ zone in
                NavigationLink {
                    OneStopDetailView(ZoneID: zone.id,ZoneName: zone.name)
                } label: {
                    Text("\(zone.name) - \(zone.town)")
                }
            }
            .id(UUID())
            .searchable(text: $searchText,
                        prompt: "Chercher un arrêt")
        }.onAppear(perform: {
            initializeZones()
        })
    }
    
    func initializeZones() {
        if allZones.isEmpty {
            let allSDZones = ZoneController.instance.getAllZones()
            for zone in allSDZones {
                context.insert(zone)
            }
        }
    }
}

#Preview {
    AllZoneView()
}
