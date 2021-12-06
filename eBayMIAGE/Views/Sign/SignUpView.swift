//
//  SignUpView.swift
//  eBayMIAGE
//
//  Created by SAINT GERMAIN on 13/11/2021.
//

import SwiftUI

struct SignUpView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var user: Utilisateur
    
    @EnvironmentObject var locationManager: LocationManager
    
    @State private var inputImage: UIImage?
    @State private var showingImagePicker = false
        
    @State var identifiant: String = ""
    @State var nom: String = ""
    @State var prenom: String = ""
    @State var mail: String = ""
    @State var mdp: String = ""
    @State var image: Image?
    
    
    var dismissClosure: (Utilisateur) -> Void
    
    private func inscription() {
        if checkInput() {
            locationManager.requestLocation()
            
            var photo: String = ""
            
            if let inputImage = inputImage {
                photo = inputImage
                    .jpegData(compressionQuality: 0)?
                    .base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters) ?? ""
            }
            
            
            let newUser = Utilisateur(identifiant: identifiant, nom: nom, prenom: prenom, mail: mail, mdp: mdp, photo: photo, latitude: "\(locationManager.location?.latitude ?? 0)", longitude: "\(locationManager.location?.longitude ?? 0)")
            
            UserApi().signUpUser(user: newUser) { userInformation in
                UserInformationDataStore.shared = userInformation

                UserApi().getUser() { user in
                    user.connectUser(user: user)
                    dismissClosure(user)
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
    
    private func checkInput() -> Bool{
        var inputIsOk = true
        
        if identifiant == "" {
            inputIsOk = false
        }
        
        if nom == "" {
            inputIsOk = false
        }
        
        if prenom == "" {
            inputIsOk = false
        }
        
        if mail == "" {
            inputIsOk = false
        }
        
        if mdp == "" {
            inputIsOk = false
        }
        
        return inputIsOk
    }
    
    private func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
    
    var body: some View {
        VStack(spacing: 10) {
            Spacer()
            
            Group {
                TextField("Identifiant", text: $identifiant)
                    .padding(.bottom)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                
                TextField("Nom", text: $nom)
                    .padding(.bottom)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                
                TextField("Prenom", text: $prenom)
                    .padding(.bottom)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                
                TextField("Mail", text: $mail)
                    .padding(.bottom)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                
                SecureField("Mot de passe", text: $mdp)
                    .textContentType(.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
            }
            
            
            image?
                .resizable()
                .scaledToFit()
            
            Button {
                showingImagePicker = true
            } label: {
                Text("Ajouter une photo")
            }
            
            Spacer()
            
            Button {
                inscription()
            } label: {
                Text("Valider l'inscription")
                    .frame(minWidth: 0, maxWidth: .infinity)
            }
            .buttonStyle(OrangeButton())
            .padding(.top)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Inscription")
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: inputImage) { _ in loadImage()  }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
        }
    }
}
