//
//  SignUpView.swift
//  eBayMIAGE
//
//  Created by SAINT GERMAIN on 13/11/2021.
//

import SwiftUI

struct SignUpView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var identifiant: String = ""
    @State var nom: String = ""
    @State var prenom: String = ""
    @State var mail: String = ""
    @State var mdp: String = ""
//    @State var photo: UIImage?
    
    private func inscription() {
        // TODO: méthode à remplir
        checkInput()
        
        presentationMode.wrappedValue.dismiss()
    }
    
    private func checkInput() {
        
    }
    
    var body: some View {
        VStack(spacing: 10) {
            Spacer()
            TextField("Identifiant", text: $identifiant)
                .padding(.bottom)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Nom", text: $nom)
                .padding(.bottom)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Prenom", text: $prenom)
                .padding(.bottom)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Mail", text: $mail)
                .padding(.bottom)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Mot de passe", text: $mdp)
                .textContentType(.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
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
