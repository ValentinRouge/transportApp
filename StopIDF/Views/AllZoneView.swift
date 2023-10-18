//
//  AllStopsView.swift
//  Arrêt Île-de-France
//
//  Created by Valentin Rouge on 13/10/2023.
//

import SwiftUI

struct AllZoneView: View {
    let allZones: [Zone]
    @State private var searchText = ""
    
    init() {
        self.allZones = ZoneController.instance.getAllZones()
    }
    
    var body: some View {
        NavigationStack {
            List{
                ForEach(searchResults, id: \.fields.zdaid){ zone in
                    NavigationLink{
                        OneStopDetailView(ZoneID: zone.fields.zdaid,ZoneName: zone.fields.zdaname)
                    } label: {
                        Text("\(zone.fields.zdaname) - \(zone.fields.zdatown)")
                    }
                }
            }
        }.searchable(text: $searchText)

    }
    
    var searchResults: [Zone] {
        if searchText.isEmpty {
            return allZones
        } else {
            return allZones.filter{$0.fields.zdaname.localizedCaseInsensitiveContains(searchText)}
        }
    }
}

#Preview {
    AllZoneView()
}
