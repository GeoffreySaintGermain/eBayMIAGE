//
//  Annonce.swift
//  eBayMIAGE
//
//  Created by SAINT GERMAIN on 13/11/2021.
//

import Foundation

class Annonce: Codable, ObservableObject {
    var id: Int
    
    var nom: String
    var description: String
    var prixPlanche: Double
    var etat: AnnouncementState
    
    var dateCreation: String
    var dateLivraison: Date?
    var duree: Int
    
    var latitude: String?
    var longitude: String?
        
    var photo: String
    
    var idUtilisateur: Int?
    
    // MARK: Computed property
    
    var dateFormatted: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
        guard let dateFormatted = dateFormatter.date(from: dateCreation) else {
            return Date.now
        }
        
        return dateFormatted
    }
    
    var endDate: Date {
        dateFormatted.addingTimeInterval(Double(duree) * 60.0)
    }
    
    // MARK: Codable
    
    enum CodingKeys: CodingKey {
        case id
        case nom
        case description
        case prixPlanche
        case etat
        case dateCreation
        case dateLivraison
        case duree
        case photo
        case idUtilisateur
        case latitude
        case longitude
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        nom = try container.decode(String.self, forKey: .nom)
        description = try container.decode(String.self, forKey: .description)
        prixPlanche = try container.decode(Double.self, forKey: .prixPlanche)
        etat = try container.decode(AnnouncementState.self, forKey: .etat)
        dateCreation = try container.decode(String.self, forKey: .dateCreation)
        dateLivraison = try container.decode(Date?.self, forKey: .dateLivraison)
        duree = try container.decode(Int.self, forKey: .duree)
        photo = try container.decode(String.self, forKey: .photo)
        idUtilisateur = try container.decode(Int.self, forKey: .idUtilisateur)
        latitude = try container.decode(String.self, forKey: .latitude)
        longitude = try container.decode(String.self, forKey: .longitude)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(nom, forKey: .nom)
        try container.encode(description, forKey: .description)
        try container.encode(prixPlanche, forKey: .prixPlanche)
        try container.encode(etat, forKey: .etat)
        try container.encode(dateCreation, forKey: .dateCreation)
        try container.encode(dateLivraison, forKey: .dateLivraison)
        try container.encode(duree, forKey: .duree)
        try container.encode(photo, forKey: .photo)
        try container.encode(photo, forKey: .idUtilisateur)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
    }
    
    // MARK: Init
    
    init(nom: String, description: String, prixPlanche: Double, duree: Int, photo: String, latitude: String, longitude: String) {
        self.id = 0
        self.dateCreation = "\(Date.now)"
        
        self.nom = nom
        self.description = description
        self.prixPlanche = prixPlanche
        self.etat = .active
        self.duree = duree
        self.photo = photo
        self.longitude = longitude
        self.latitude = latitude
    }
    
    // MARK: Enum
    
    public enum AnnouncementState: String, Codable {
        case active = "active"
        case cloturee = "cloturee"
    }
}
