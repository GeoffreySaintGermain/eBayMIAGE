
//
//  Utilisateur.swift
//  eBayMIAGE
//
//  Created by SAINT GERMAIN on 13/11/2021.
//

import Foundation

class Utilisateur: ObservableObject {
    
    /// singleton
    public static var shared = Utilisateur()
    @Published var isChanged = false
                
    @Published var id: UUID?
    
    @Published var identifiant: String
    @Published var nom: String
    @Published var prenom: String
    @Published var mail: String
    @Published var mdp: String
    @Published var photo: String?
    
    @Published var date: Date?
    
    @Published var latitude: String
    @Published var longitude: String
    
    public var isLogged: Bool {
        id != nil
    }
    
//    init(nom: String, prenom: String, mail: String, mdp: String, photo: String? = nil, latitude: String? = nil, longitude: String? = nil) {
//        self.identifiant = nil
//        self.id = UUID()
//        self.nom = nom
//        self.prenom = prenom
//        self.mail = mail
//        self.mdp = mdp
//        self.photo = photo
//        self.date = Date.now
//        self.latitude = latitude
//        self.longitude = longitude
//    }
    
    private init() {
        self.identifiant = ""
        self.nom = ""
        self.prenom = ""
        self.mail = ""
        self.mdp = ""
        self.latitude = ""
        self.longitude = ""
    }

    public func connexion(identifiant: String, nom: String, prenom: String, mail: String, mdp: String, photo: String? = nil, latitude: String = "", longitude: String = "") {
        self.id = UUID()
        self.date = Date.now
        
        self.identifiant = identifiant
        self.nom = nom
        self.prenom = prenom
        self.mail = mail
        self.mdp = mdp
        self.photo = photo
        self.latitude = latitude
        self.longitude = longitude
    }
    
    public func deconnectUser() {
        emptyUser()
    }
    
    private func emptyUser() {
        self.id = nil
        
        self.identifiant = ""
        self.nom = ""
        self.prenom = ""
        self.mail = ""
        self.mdp = ""
        self.latitude = ""
        self.longitude = ""
    }
}
