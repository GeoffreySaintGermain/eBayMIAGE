
//
//  Utilisateur.swift
//  eBayMIAGE
//
//  Created by SAINT GERMAIN on 13/11/2021.
//

import Foundation

class Utilisateur: ObservableObject {
    var identifiant: String?
    var id: UUID
    
    var nom: String
    var prenom: String
    var mail: String
    var mdp: String
    var photo: String?
    
    var date: Date
    
    var latitude: String?
    var longitude: String?
    
    init(nom: String, prenom: String, mail: String, mdp: String, photo: String? = nil, latitude: String? = nil, longitude: String? = nil) {
        self.identifiant = nil
        self.id = UUID()
        self.nom = nom
        self.prenom = prenom
        self.mail = mail
        self.mdp = mdp
        self.photo = photo
        self.date = Date.now
        self.latitude = latitude
        self.longitude = longitude
    }
    
}
