//
//  SignInView.swift
//  eBayMIAGE
//
//  Created by SAINT GERMAIN on 13/11/2021.
//

import SwiftUI

struct SignInView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var user: Utilisateur
    
    @State var idUser: String = ""
    @State var password: String = ""
    
    var dismissClosure: (Utilisateur) -> Void
    
    private func connectUser() {
        if checkInput() {
            UserApi().connectUser(idUser: idUser, password: password) { userInformation in
                UserInformationDataStore.shared = userInformation
                
                UserApi().getUser() { user in
                    user.connectUser(user: user)
                    dismissClosure(user)
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
    
    private func checkInput() -> Bool {
        var inputIsOk = true
        
        if idUser == "" {
            inputIsOk = false
        }
        
        if password == "" {
            inputIsOk = false
        }
        
        return inputIsOk
    }
    
    var body: some View {
        VStack {
            Spacer()
            TextField("Nom d'utilisateur", text: $idUser)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .padding(.bottom)
            
            TextField("Mot de passe", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())            
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
            
            Button() {
                connectUser()
            } label: {
                Text("Connexion")
                    .frame(minWidth: 0, maxWidth: .infinity)
            }
            .buttonStyle(OrangeButton())
            .padding(.top)
            
            Spacer()
            
        }
        .padding()
        .navigationTitle("Connexion")
        .navigationBarTitleDisplayMode(.inline)
    }
}

