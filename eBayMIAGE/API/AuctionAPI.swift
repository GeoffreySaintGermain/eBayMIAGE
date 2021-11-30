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
                    print("error while fetching data")
                    return
                }
                
                do {
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
    
    func getHistoricAuctions(completion: @escaping ([Enchere]) -> ()) {
        let apiPathHistoric = "apiPathAuction\(UserInformationDataStore.shared.id)"
        
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
                    print("error while fetching data")
                    return
                }
                
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
    
    
}
