//
//  NavigationLazyView.swift
//  StopIDF
//
//  Created by Valentin Rouge on 30/10/2023.
//

import SwiftUI

struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}

#Preview {
    NavigationLazyView(Text("Hello"))
}
