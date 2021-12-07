//
//  AnnounceAPI.swift
//  eBayMIAGE
//
//  Created by SAINT GERMAIN on 29/11/2021.
//

import Foundation

class AnnounceAPI {
    
    let apiPathAnnounce = APIUtils.ApiPath + "annonces"
    let apiPathCreateAnnounce = APIUtils.ApiPath + "utilisateurs/\(UserInformationDataStore.shared.id)/annonces"    

    // MARK: API Calls
    
    func getAnnouncements(completion: @escaping ([Annonce]) -> ()) {
        if UserInformationDataStore.shared.informationFilled {
            
            guard let url = URL(string: apiPathCreateAnnounce) else {
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
    
    func createAnnouncement(newAnnouncement: Annonce, completion: @escaping (Bool) -> ()) {
        guard let url = URL(string: apiPathCreateAnnounce) else {
            print("invalid url")
            return
        }
        
        guard let httpBody = try? JSONEncoder().encode(newAnnouncement) else {
            print("Failed to encode user")
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(UserInformationDataStore.shared.token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.httpBody = httpBody
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error == nil {
                completion(true)
            } else {
                completion(false)
            }
        }.resume()
    }        
}
