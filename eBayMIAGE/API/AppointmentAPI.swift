//
//  AppointmentAPI.swift
//  eBayMIAGE
//
//  Created by SAINT GERMAIN on 07/12/2021.
//

import Foundation

class AppointmentAPI {
    
    let apiPathAppointment = APIUtils.ApiPath + "livraison/"
    
    func fixAppointment(appointment: Appointment, completion: @escaping (Bool) -> ()) {
        let apiPathFixAppointment = "\(apiPathAppointment)annonces/\(appointment.idAnnouncement)"
        
        guard let url = URL(string: apiPathFixAppointment) else {
            print("invalid url")
            return
        }
        
        guard let httpBody = try? JSONEncoder().encode(appointment) else {
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
