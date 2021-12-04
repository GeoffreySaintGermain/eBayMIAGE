//
//  Enchere.swift
//  eBayMIAGE
//
//  Created by SAINT GERMAIN on 13/11/2021.
//

import Foundation

class Enchere: Codable, ObservableObject {
    
    var id: Int?
    var idUtilisateur: Int?
    var idAnnonce: Int?
    
    var prix: Double
    var date: String
    var gagne: Int?
    
    // MARK: Computed propreties
    
    var isGagne: Bool {
        return gagne == 1
    }
    
    var dateFormatted: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
        guard let dateFormatted = dateFormatter.date(from: date) else {
            return Date.now
        }
        
        return dateFormatted
    }
    
    // MARK: Codable
    
    enum CodingKeys: CodingKey {
        case id
        case idUtilisateur
        case idAnnonce
        case prix
        case date
        case gagne
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        idUtilisateur = try container.decode(Int.self, forKey: .idUtilisateur)
        idAnnonce = try container.decode(Int.self, forKey: .idAnnonce)
        prix = try container.decode(Double.self, forKey: .prix)
        date = try container.decode(String.self, forKey: .date)
        gagne = try container.decode(Int.self, forKey: .gagne)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(idUtilisateur, forKey: .idUtilisateur)
        try container.encode(idAnnonce, forKey: .idAnnonce)
        try container.encode(prix, forKey: .prix)
        try container.encode(date, forKey: .date)
        try container.encode(gagne, forKey: .gagne)
    }
    
    // MARK: Init
    
    init(prix: Double) {
        self.prix = prix
        self.date = "\(Date.now)"
    }
}
