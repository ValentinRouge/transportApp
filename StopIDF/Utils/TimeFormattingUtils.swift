//
//  TimeFormattingUtils.swift
//  StopIDF
//
//  Created by Valentin Rouge on 21/10/2023.
//

import Foundation

class TimeFormattingUtils {
    static func convertMinToHMin(time: Int) -> String {
        if time>60{
            let (hours, minutes) = time.quotientAndRemainder(dividingBy: 60)
            return ("\(hours)h\(String(format: "%02d", minutes))")
        } else {
            return "\(time) min"
        }
    }
    
}
