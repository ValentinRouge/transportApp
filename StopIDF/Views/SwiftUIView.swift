//
//  SwiftUIView.swift
//  StopIDF
//
//  Created by Valentin Rouge on 22/10/2023.
//

import SwiftUI
import SwiftData

struct SwiftUIView: View {
    @Environment(\.modelContext) var context
    @Query var datas: [SDZones]
    
    init() {
        
//        context.insert(SDZones(id: "test", postalCode: "tes", mode: "tes", yCoordinates: 12, xCoordinates: 12, town: "tes", name: "tes"))
        print(datas)
    }
    
    var body: some View {
        VStack {
            ForEach(datas){ data in
                Text(data.id)
            }
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Button(action: {
                context.insert(SDZones(id: "testt", postalCode: "tes", mode: "tes", yCoordinates: 12, xCoordinates: 12, town: "tes", name: "tes"))
            }, label: {
                Text("Add")
            })
        }
        .padding()
    }
}

#Preview {
    SwiftUIView()
}
