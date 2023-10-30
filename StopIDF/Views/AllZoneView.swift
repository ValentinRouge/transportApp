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
    @Query(
        sort: [SortDescriptor(\SDZones.town, order: .forward), SortDescriptor(\SDZones.name, order: .forward)]
    ) var allZones: [SDZones]
    @State private var searchText = ""
    @State private var searchResults: [SDZones] = []
    @State private var visibleResults: [SDZones] = [] // Les éléments actuellement visibles
    @State private var pageSize = 20 // Nombre d'éléments à charger à la fois
    @State private var currentPage = 1 // Page actuelle
    
    var body: some View {
        NavigationStack {
            List(visibleResults, id: \.id) { zone in
                NavigationLink {
                    OneStopDetailView(ZoneID: zone.id, ZoneName: zone.name)
                } label: {
                    Text("\(zone.name) - \(zone.town)")
                }
                .onAppear {
                    // Chargement de plus d'éléments lorsque l'utilisateur atteint le bas de la liste
                    if zone == visibleResults.last {
                        currentPage += 1
                        loadMoreResults()
                    }
                }
            }
            .onAppear {
                performSearch()
            }
            .searchable(text: $searchText, prompt: "Chercher un arrêt")
            .onChange(of: searchText) {
                // Réinitialisation de la pagination lorsqu'une nouvelle recherche est effectuée
                currentPage = 1
                visibleResults.removeAll()
                performSearch()
            }
        }
    }

    private func performSearch() {
        Task {
            if searchText.isEmpty {
                searchResults = allZones
            } else {
                searchResults = allZones.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
            }
            loadMoreResults()
        }
    }
    
    private func loadMoreResults() {
        // Charger plus d'éléments à partir des résultats de recherche
        let startIndex = (currentPage - 1) * pageSize
        let endIndex = min(startIndex + pageSize, searchResults.count)
        if startIndex < endIndex {
            let newResults = Array(searchResults[startIndex..<endIndex])
            visibleResults.append(contentsOf: newResults)
        }
    }
}

#Preview {
    AllZoneView()
}
