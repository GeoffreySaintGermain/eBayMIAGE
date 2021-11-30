//
//  Enchere.swift
//  eBayMIAGE
//
//  Created by SAINT GERMAIN on 13/11/2021.
//

import Foundation

class Enchere: Codable, ObservableObject {
    var prix: Double
    var date: Date
    
    init(prix: Double) {
        self.prix = prix
        self.date = Date.now
    }
}
