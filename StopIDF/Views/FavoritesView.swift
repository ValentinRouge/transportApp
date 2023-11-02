//
//  FavoritesView.swift
//  StopIDF
//
//  Created by Valentin Rouge on 02/11/2023.
//

import SwiftUI
import SwiftData

struct FavoritesView: View {
    @Environment(\.modelContext) var context
    @Query(filter: #Predicate<SDZones> { $0.isFavorite == true},
        sort: [SortDescriptor(\SDZones.town, order: .forward), SortDescriptor(\SDZones.name, order: .forward)]
    ) var allZones: [SDZones]
        
    var body: some View {
        ScrollView {
            ForEach(allZones) { zone in
                OneStopDetailView(Zone: zone)
            }
        }
    }
}

#Preview {
    FavoritesView()
        .modelContainer(PreviewZoneData.container)
}
