//
//  AuctionAPI.swift
//  eBayMIAGE
//
//  Created by SAINT GERMAIN on 30/11/2021.
//

import Foundation

class AuctionAPI {
    
    let apiPathAuction = APIUtils.ApiPath + "enchere/annonces/"
            
    func getMyAuctions(completion: @escaping ([Annonce]) -> ()) {
        let apiPathMyAuction = apiPathAuction + "utilisateurs/\(UserInformationDataStore.shared.id)"
        
        if UserInformationDataStore.shared.informationFilled {
            
            guard let url = URL(string: apiPathMyAuction) else {
                print("invalid URL")
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \(UserInformationDataStore.shared.token)", forHTTPHeaderField: "Authorization")
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                
                guard let data = data else {
                    print("error no data")
                    return
                }
                
                do {
                    let str = String(decoding: data, as: UTF8.self)
                    print(str)
                    
                    let decodedAnnouncements = try JSONDecoder().decode([Annonce].self, from: data)
                    print(decodedAnnouncements)
                    DispatchQueue.main.async {
                        completion(decodedAnnouncements)
                    }
                } catch {
                    print("error in decoding json")
                }
                
            }.resume()
        } else {
            print("User not log in")
        }
    }
    
    func getHistoricAuctions(annonceId: Int, completion: @escaping ([Enchere]) -> ()) {
        let apiPathHistoric = "\(apiPathAuction)\(annonceId)"
        
        if UserInformationDataStore.shared.informationFilled {
            
            guard let url = URL(string: apiPathHistoric) else {
                print("invalid URL")
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \(UserInformationDataStore.shared.token)", forHTTPHeaderField: "Authorization")
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data else {
                    print("error no data historic")
                    if let error = error {
                        print(error.localizedDescription)
                    }
                    return
                }
                                
                let str = String(decoding: data, as: UTF8.self)
                print(str)
                
                do {
                    let decodedAuctions = try JSONDecoder().decode([Enchere].self, from: data)
                    print(decodedAuctions)
                    DispatchQueue.main.async {
                        completion(decodedAuctions)
                    }
                } catch {
                    print("error in decoding json")
                }
                
            }.resume()
        } else {
            print("User not log in")
        }
    }
    
    func bidOnAnnoucement(auction: Enchere, announcement: Annonce, completion: @escaping (Bool) -> ()) {
        let apiPathBidAnnouncement = "\(apiPathAuction)\(announcement.id)/utilisateurs/\(UserInformationDataStore.shared.id)"
        
        guard let url = URL(string: apiPathBidAnnouncement) else {
            print("invalid url")
            return
        }
        
        guard let httpBody = try? JSONEncoder().encode(auction) else {
            print("Failed to encode user")
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(UserInformationDataStore.shared.token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.httpBody = httpBody
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("no data")
                return
            }
            let str = String(decoding: data, as: UTF8.self)
            print(str)
            
            DispatchQueue.main.async {
                if error == nil {
                    completion(false)
                } else {
                    completion(true)
                }
            }
        }.resume()
    }
}
