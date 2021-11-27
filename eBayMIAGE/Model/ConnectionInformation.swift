//
//  ConnectionInformation.swift
//  eBayMIAGE
//
//  Created by SAINT GERMAIN on 27/11/2021.
//

import SwiftUI

class ConnectionInformation: Codable {
    var identifiant: String
    var motDePasse: String
    
    public init(identifiant: String, motDePasse: String) {
        self.identifiant = identifiant
        self.motDePasse = motDePasse
    }
}
