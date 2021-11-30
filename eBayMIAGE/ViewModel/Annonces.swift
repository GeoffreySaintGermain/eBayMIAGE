//
//  Annonces.swift
//  eBayMIAGE
//
//  Created by SAINT GERMAIN on 29/11/2021.
//

import Foundation

class Announcements: ObservableObject {
    @Published var announcements: [Annonce]
    
    init(annonces: [Annonce]) {
        self.announcements = annonces
    }
}
