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
    
    @State var identifiant: String = ""
    @State var nom: String = ""
    @State var prenom: String = ""
    @State var mail: String = ""
    @State var mdp: String = ""
    // @State var photo: UIImage?
    
    private func inscription() {
        if checkInput() {
            let newUser = Utilisateur(identifiant: identifiant, nom: nom, prenom: prenom, mail: mail, mdp: mdp)
            
            UserApi().signUpUser(user: newUser) { userInformation in
                UserInformationDataStore.shared = userInformation
                
                UserApi().getUser() { user in
                    user.connectUser(user: user)
                    print(user.id)
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
    
    var body: some View {
        VStack(spacing: 10) {
            Spacer()
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
            
            TextField("Mot de passe", text: $mdp)
                .textContentType(.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
            
            Button{
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
    }
}
