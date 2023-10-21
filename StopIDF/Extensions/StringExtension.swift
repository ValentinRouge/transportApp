//
//  StringExtension.swift
//  StopIDF
//
//  Created by Valentin Rouge on 20/10/2023.
//

import Foundation

extension String {
    func isEqualIgnoringCaseDiacriticsAndHyphen(_ other: String) -> Bool {
        return self.replacingOccurrences(of: "-", with: " ").compare(other.replacingOccurrences(of: "-", with: " "), options: [.caseInsensitive, .diacriticInsensitive]) == .orderedSame
    }
}
