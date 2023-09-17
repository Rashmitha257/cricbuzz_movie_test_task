//
//  String + Extension.swift
//  Movies
//
//  Created by Softsuave on 16/09/2023.
//

import Foundation

extension String {
   
    func isNotEmpty() -> Bool {
        return self != "" && self != "N/A"
    }
    
    func trim() -> String {
        return (trimmingCharacters(in: .whitespacesAndNewlines))
    }
}
