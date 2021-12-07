//
//  Appointment.swift
//  eBayMIAGE
//
//  Created by SAINT GERMAIN on 07/12/2021.
//

import Foundation

class Appointment: Codable {
    var idAnnouncement: Int
    var dateAppointment: String
    
    public init(idAnnouncement: Int, dateAppointment: Date) {
        self.idAnnouncement = idAnnouncement
        self.dateAppointment = dateAppointment.ISO8601Format()
    }
}
