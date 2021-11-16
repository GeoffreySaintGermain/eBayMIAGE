//
//  Annonce.swift
//  eBayMIAGE
//
//  Created by SAINT GERMAIN on 13/11/2021.
//

import Foundation

class Annonce: ObservableObject {
    var id: UUID
    
    var nom: String
    var description: String
    var prixPlanche: String
    var etat: Int
    
    var dateCreation: Date
    var dateLivraison: Date?
    var duree: Date
        
    var photo: String
    
    internal init(nom: String, description: String, prixPlanche: String, etat: Int, duree: Date, photo: String) {
        self.id = UUID()
        self.dateCreation = Date.now
        
        self.nom = nom
        self.description = description
        self.prixPlanche = prixPlanche
        self.etat = etat
        self.duree = duree
        self.photo = photo
    }
}
