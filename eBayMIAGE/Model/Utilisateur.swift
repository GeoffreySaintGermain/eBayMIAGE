
//
//  Utilisateur.swift
//  eBayMIAGE
//
//  Created by SAINT GERMAIN on 13/11/2021.
//

import Foundation
import SwiftUI

class Utilisateur: Codable, ObservableObject {
    
    // MARK: Attributes
    
    @Published var id: Int?
    
    @Published var identifiant: String?
    @Published var nom: String
    @Published var prenom: String
    @Published var mail: String?
    @Published var mdp: String?
    @Published var photo: String?
    
    @Published var latitude: String
    @Published var longitude: String
    
    // MARK: Computed properties
    
    var isLogged: Bool {
        id != nil
    }
    
    var photoFrom64Encoded: Image? {
        guard let photo = photo else {
            return nil
        }
        
        if let data = Data(base64Encoded: photo, options: .ignoreUnknownCharacters), let uiImage = UIImage(data: data) {
                return Image(uiImage: uiImage)
        } else {
            return nil
        }
    }
    
    // MARK: Codable

    enum CodingKeys: CodingKey {
        case id
        case identifiant
        case nom
        case prenom
        case mail
        case mdp
        case photo
        case date
        case latitude
        case longitude
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        identifiant = try container.decodeIfPresent(String.self, forKey: .identifiant)
        nom = try container.decode(String.self, forKey: .nom)
        prenom = try container.decode(String.self, forKey: .prenom)
        mail = try container.decodeIfPresent(String.self, forKey: .mail)
        mdp = try container.decodeIfPresent(String.self, forKey: .mdp)
        photo = try container.decodeIfPresent(String.self, forKey: .photo)
        latitude = try container.decode(String.self, forKey: .latitude)
        longitude = try container.decode(String.self, forKey: .longitude)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(identifiant, forKey: .identifiant)
        try container.encode(nom, forKey: .nom)
        try container.encode(prenom, forKey: .prenom)
        try container.encode(mail, forKey: .mail)
        try container.encode(mdp, forKey: .mdp)
        try container.encode(photo, forKey: .photo)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
    }
    
    // MARK: Init
    
    public init(identifiant: String, nom: String, prenom: String, mail: String, mdp: String, photo: String? = nil, latitude: String = "", longitude: String = "") {
        self.identifiant = identifiant
        self.nom = nom
        self.prenom = prenom
        self.mail = mail
        self.mdp = mdp
        self.photo = photo
        self.latitude = latitude
        self.longitude = longitude
        self.photo = photo
    }

    public init() {
        self.identifiant = ""
        self.nom = ""
        self.prenom = ""
        self.mail = ""
        self.mdp = ""
        self.latitude = ""
        self.longitude = ""
        self.photo = ""
    }
    
    // MARK: Functions

    public func connexion(identifiant: String, nom: String, prenom: String, mail: String, mdp: String, photo: String? = nil, latitude: String = "", longitude: String = "") {
        self.identifiant = identifiant
        self.nom = nom
        self.prenom = prenom
        self.mail = mail
        self.mdp = mdp
        self.photo = photo
        self.latitude = latitude
        self.longitude = longitude
        self.photo = ".jpg"
    }
    
    public func connectUser(user: Utilisateur) {
        self.id = user.id
        self.identifiant = user.identifiant
        self.nom = user.nom
        self.prenom = user.prenom
        self.mail = user.mail
        self.mdp = user.mdp
        self.photo = user.photo
        self.latitude = user.latitude
        self.longitude = user.longitude
        self.photo = user.photo
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
