//
//  Annonce.swift
//  eBayMIAGE
//
//  Created by SAINT GERMAIN on 13/11/2021.
//

import Foundation

class Annonce: ObservableObject {
    var id: Int
    
    var nom: String
    var description: String
    var prixPlanche: String
    var etat: Int
    
    var dateCreation: Date
    var dateLivraison: Date
    var duree: Date
        
    var photo: String
    
    internal init(id: Int, nom: String, description: String, prixPlanche: String, etat: Int, dateCreation: Date, dateLivraison: Date, duree: Date, photo: String) {
        self.id = id
        self.nom = nom
        self.description = description
        self.prixPlanche = prixPlanche
        self.etat = etat
        self.dateCreation = dateCreation
        self.dateLivraison = dateLivraison
        self.duree = duree
        self.photo = photo
    }
}
