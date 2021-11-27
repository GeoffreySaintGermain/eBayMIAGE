//
//  NouvelleAnnonce.swift
//  eBayMIAGE
//
//  Created by SAINT GERMAIN on 13/11/2021.
//

import SwiftUI

struct NewAnnouncementSheetView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var hours: Int = 0
    @State private var minutes: Int = 5
            
    var dismissClosure: (Annonce) -> Void
    
    @State var announcementName: String = ""
    @State var announcementDescription: String = ""
    @State var announcementPrice: Double?
    @State var announcementDuration: Int = 500
    @State var announcementLatitude: String?
    @State var announcementLongitude: String?
    
    private func sendAnnouncement() {
        // TODO: Check user input
        
        announcementDuration = hours*60 + minutes
        
        let newAnnouncement = Annonce(nom: announcementName, description: announcementDescription, prixPlanche: announcementPrice ?? 0, duree: announcementDuration, photo: "")
        
        dismissClosure(newAnnouncement)
        dismiss()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Créer une annonce")
                .font(.title)
                .bold()
                .padding(.bottom)
            
            TextField("Nom", text: $announcementName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Description", text: $announcementDescription)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Prix", value: $announcementPrice, formatter: NumberFormatter())
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
            
            Text("Fixer la durée de l'enchère")
            
            HStack {
                Spacer()
                VStack {
                    Picker("", selection: $hours){
                        ForEach(0..<9, id: \.self) { i in
                            Text("\(i) heures").tag(i)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                }
                .frame(width: 100)
                .clipped()
                
                VStack {
                    Picker("", selection: $minutes){
                        ForEach(0..<60, id: \.self) { i in
                            Text("\(i) minutes").tag(i)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                }
                .frame(width: 100)
                .clipped()
                                
                Spacer()
            }.padding(.horizontal)
            
            Button {
                sendAnnouncement()
            } label: {
                Text("Envoyer")
                    .frame(minWidth: 0, maxWidth: .infinity)
            }
            
            .buttonStyle(OrangeButton())
        }
        .padding()
    }
}