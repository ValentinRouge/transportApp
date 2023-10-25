//
//  Arre_t_I_le_de_FranceApp.swift
//  Arrêt Île-de-France
//
//  Created by Valentin Rouge on 10/10/2023.
//

import SwiftUI
import SwiftData

@main
struct StopIDFApp: App {
    @AppStorage("LineUpdateDate") var lineUpdateDate: Date = Date(timeIntervalSince1970: 0)
    
    var body: some Scene {
        WindowGroup {
            TabsView()
        }
        .modelContainer(LineContainer.create(lastUpdateDate: &lineUpdateDate))
    }
}
