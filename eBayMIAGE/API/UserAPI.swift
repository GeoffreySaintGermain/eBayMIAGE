//
//  UserAPI.swift
//  eBayMIAGE
//
//  Created by SAINT GERMAIN on 27/11/2021.
//

import Foundation

class UserApi {
    let apiPathUser = APIUtils.ApiPath + "utilisateurs"
    let apiPathLogin = APIUtils.ApiPath + "login"
        
    // MARK: API CALL
    func signUpUser(user: Utilisateur, completion: @escaping (UserInformation) -> ()) {
        guard let url = URL(string: apiPathUser) else {
            print("invalid url")
            return
        }
        
        guard let httpBody = try? JSONEncoder().encode(user) else {
            print("Failed to encode user")
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = httpBody
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("error in fetching data")
                return
            }
            
            let str = String(decoding: data, as: UTF8.self)
            print(str)
            
            do {
                let decodedUserInformation = try JSONDecoder().decode(UserInformation.self, from: data)
                print(decodedUserInformation)
                
                DispatchQueue.main.async {
                    completion(decodedUserInformation)
                }
            } catch {
                print("error")
            }
        }.resume()
    }
    
    func connectUser(idUser: String, password: String, completion: @escaping (UserInformation) -> ()) {
        let connectionInformation = ConnectionInformation(identifiant: idUser, motDePasse: password)
        
        guard let url = URL(string: apiPathLogin) else {
            print("invalid url")
            return
        }
        
        guard let httpBody = try? JSONEncoder().encode(connectionInformation) else {
            print("Failed to encode user")
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = httpBody
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("error in fetching data")
                return
            }
            
            let str = String(decoding: data, as: UTF8.self)
            print(str)
            
            do {
                let decodedUserInformation = try JSONDecoder().decode(UserInformation.self, from: data)
                print(decodedUserInformation)
                
                DispatchQueue.main.async {
                    completion(decodedUserInformation)
                }
            } catch {
                print("error")
            }
        }.resume()
    }
    
    func getUser(completion: @escaping (Utilisateur) -> ()) {
        if UserInformationDataStore.shared.informationFilled {
            
            guard let url = URL(string: "\(apiPathUser)/\(UserInformationDataStore.shared.id)") else {
                print("invalid URL")
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \(UserInformationDataStore.shared.token)", forHTTPHeaderField: "Authorization")
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                
                let decodedUser = try! JSONDecoder().decode(Utilisateur.self, from: data!)
                print(decodedUser)
                DispatchQueue.main.async {
                    completion(decodedUser)
                }
            }.resume()
        } else {
            print("User not log in")
        }
    }
}
