
//
//  Utilisateur.swift
//  eBayMIAGE
//
//  Created by SAINT GERMAIN on 13/11/2021.
//

import Foundation

class Utilisateur {
    var identifiant: String
    var id: Int
    
    var nom: String
    var prenom: String
    var mail: String
    var mdp: String
    var photo: String
    
    var date: Date
    
    var latitude: String
    var longitude: String
    
    init(identifiant: String, id: Int, nom: String, prenom: String, mail: String, mdp: String, photo: String, date: Date, latitude: String, longitude: String) {
        self.identifiant = identifiant
        self.id = id
        self.nom = nom
        self.prenom = prenom
        self.mail = mail
        self.mdp = mdp
        self.photo = photo
        self.date = date
        self.latitude = latitude
        self.longitude = longitude
    }
    
}
