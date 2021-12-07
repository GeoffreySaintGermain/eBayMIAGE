//
//  Appointment.swift
//  eBayMIAGE
//
//  Created by SAINT GERMAIN on 07/12/2021.
//

import Foundation

class Appointment: Codable {
    var idAnnouncement: Int
    var date: String
    
    public init(idAnnouncement: Int, dateAppointment: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        self.idAnnouncement = idAnnouncement
        self.date = formatter.string(from: dateAppointment)
    }
}
