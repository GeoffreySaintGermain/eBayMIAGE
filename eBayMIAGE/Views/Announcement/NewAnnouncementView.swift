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
    
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State var image: Image?
    
    private func sendAnnouncement() {        
        if checkInput() {
            var photo: String = ""
            
            if let inputImage = inputImage {
                photo = inputImage
                    .jpegData(compressionQuality: 0)?
                    .base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters) ?? ""
            }
            
            announcementDuration = hours*60 + minutes
            
            let newAnnouncement = Annonce(nom: announcementName, description: announcementDescription, prixPlanche: announcementPrice ?? 0, duree: announcementDuration, photo: photo, latitude: "\(locationManager.location?.latitude ?? 0)", longitude: "\(locationManager.location?.longitude ?? 0)")
            
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
    
    private func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
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
            
            HStack {
                Spacer()
                image?
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                Spacer()
            }
            
            Button {
                showingImagePicker = true
            } label: {
                Text("Ajouter une photo")
            }
            
            Button {
                sendAnnouncement()
            } label: {
                Text("Envoyer")
                    .frame(minWidth: 0, maxWidth: .infinity)
            }
            
            .buttonStyle(OrangeButton())
        }
        .padding()
        .onChange(of: inputImage) { _ in loadImage()  }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
        }
    }
    
}
