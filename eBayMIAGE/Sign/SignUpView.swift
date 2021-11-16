//
//  SignUpView.swift
//  eBayMIAGE
//
//  Created by SAINT GERMAIN on 13/11/2021.
//

import SwiftUI

struct SignUpView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var nom: String = ""
    @State var prenom: String = ""
    @State var mail: String = ""
    @State var mdp: String = ""
//    @State var photo: UIImage?
    
    private func inscription() {
        // TODO: méthode à remplir

        presentationMode.wrappedValue.dismiss()
    }
    
    var body: some View {
        VStack(spacing: 10) {
            Spacer()
            TextField("Nom", text: $nom)
                .padding(.bottom)
            TextField("Prenom", text: $prenom)
                .padding(.bottom)
            TextField("Mail", text: $mail)
                .padding(.bottom)
            TextField("Mot de passe", text: $mdp)
            
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
