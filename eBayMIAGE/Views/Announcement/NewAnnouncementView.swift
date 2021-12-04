//
//  NouvelleAnnonce.swift
//  eBayMIAGE
//
//  Created by SAINT GERMAIN on 13/11/2021.
//

import SwiftUI

struct NewAnnouncementSheetView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var locationManager: LocationManager
    
    @State private var hours: Int = 0
    @State private var minutes: Int = 5
            
    var dismissClosure: () -> Void
    
    @State var announcementName: String = ""
    @State var announcementDescription: String = ""
    @State var announcementPrice: Double?
    @State var announcementDuration: Int = 500
    @State var announcementLatitude: String?
    @State var announcementLongitude: String?
    
    private func sendAnnouncement() {        
        if checkInput() {
            announcementDuration = hours*60 + minutes
            
            let newAnnouncement = Annonce(nom: announcementName, description: announcementDescription, prixPlanche: announcementPrice ?? 0, duree: announcementDuration, photo: "", latitude: "\(locationManager.location?.latitude ?? 0)", longitude: "\(locationManager.location?.longitude ?? 0)")
            
            AnnounceAPI().createAnnouncement(newAnnouncement: newAnnouncement) { isOk in
                if isOk {
                    dismissClosure()
                    dismiss()
                }
                else {
                    print("error")
                }
            }
            
            
        }
    }
    
    private func checkInput() -> Bool {
        var inputIsOk = true
        
        if announcementName == "" {
            inputIsOk = false
        }
        
        if announcementDescription == "" {
            inputIsOk = false
        }
        
        if announcementPrice == nil || announcementPrice == 0 {
            inputIsOk = false
        }
        
        return inputIsOk
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
