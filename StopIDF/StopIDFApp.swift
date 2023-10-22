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
    let modelContainer: ModelContainer
    
    init() {
        do {
            modelContainer = try ModelContainer(for: SDZones.self)
        } catch {
            fatalError("Could not initialize ModelContainer")
        }
    }

    
    var body: some Scene {
        WindowGroup {
            TabsView()
        }
        .modelContainer(modelContainer)
    }
}
