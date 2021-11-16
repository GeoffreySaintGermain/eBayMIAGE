//
//  NouvelleAnnonce.swift
//  eBayMIAGE
//
//  Created by SAINT GERMAIN on 13/11/2021.
//

import SwiftUI

struct NewAnnouncementSheetView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var date = Date()
            
    var dismissClosure: (Annonce) -> Void
    
    @State var announcementName: String = ""
    @State var announcementDescription: String = ""
    @State var announcementPrice: Double = 0
    @State var announcementDuration: Int = 500
    @State var announcementLatitude: String?
    @State var announcementLongitude: String?
    
    private func sendAnnouncement() {
        let newAnnouncement = Annonce(nom: announcementName, description: announcementDescription, prixPlanche: announcementPrice, duree: announcementDuration, photo: "")
        
        dismissClosure(newAnnouncement)        
        dismiss()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Annonce N145", text: $announcementName)
            TextField("TXT ANNONCE", text: $announcementDescription)
            TextField("132€", value: $announcementPrice, formatter: NumberFormatter())
            
            Text("Fixer la date de la fin de l'enchère")
            
            DatePicker(
                "Start Date",
                selection: $date,
                displayedComponents: [.date]
            )
                .datePickerStyle(.compact)
            
            Button("Envoyer") {
                sendAnnouncement()
            }
            .buttonStyle(OrangeButton())
        }
    }
}
