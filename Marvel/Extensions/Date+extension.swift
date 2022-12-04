//
//  Date+extension.swift
//  RickAndMorty
//
//  Created by Daniel Personal on 3/12/22.
//

import Foundation

extension Date {
    
    func format(format: String = Constants.dateFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
}
