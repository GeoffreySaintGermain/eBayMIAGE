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
    var prixPlanche: Double
    var etat: AnnouncementState
    
    var dateCreation: Date
    var dateLivraison: Date?
    var duree: Int
        
    var photo: String
    
    internal init(nom: String, description: String, prixPlanche: Double, duree: Int, photo: String) {
        self.id = UUID()
        self.dateCreation = Date.now
        
        self.nom = nom
        self.description = description
        self.prixPlanche = prixPlanche
        self.etat = .active
        self.duree = duree
        self.photo = photo
    }
    
    // MARK: Enum
    
    public enum AnnouncementState: String {
        case active = "active"
        case cloturee = "cloturee"
    }
}
