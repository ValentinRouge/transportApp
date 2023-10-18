//
//  OneTimeView.swift
//  StopIDF
//
//  Created by Valentin Rouge on 18/10/2023.
//

import SwiftUI

struct OneTimeView: View {
    let time: String
    
    
    init(time: Int?) {
        if let unwrappedTime = time {
            if unwrappedTime <= 0 {
                self.time = "<1 min"
            } else {
                self.time = "\(unwrappedTime) min"
            }
        } else {
            self.time = "NA"
        }
    }
    
    var body: some View {
        Text(time)
            .padding([.horizontal], 5)
            .padding([.vertical], 2)
            .foregroundStyle(Color.white)
            .background(Color(.green))
            .clipShape(RoundedRectangle(cornerSize: /*@START_MENU_TOKEN@*/CGSize(width: 20, height: 10)/*@END_MENU_TOKEN@*/, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
    }
}

#Preview {
    OneTimeView(time: 5)
}
