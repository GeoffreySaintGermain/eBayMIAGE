//
//  Formatter+extension.swift
//  eBayMIAGE
//
//  Created by SAINT GERMAIN on 07/12/2021.
//

import Foundation

extension Formatter {
    
    static let weekDay: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr")
        return formatter
    }()
}

