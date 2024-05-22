//
//  String.swift
//  WDIW
//
//  Created by Nicolas von Trott on 22.05.24.
//

import Foundation

extension String {
    var capitalizedSentence: String {
        let firstLetter = self.prefix(1).capitalized
        let remainingLetters = self.dropFirst().lowercased()
        return firstLetter + remainingLetters
    }
}
