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
        let newUser = Utilisateur(nom: nom, prenom: prenom, mail: mail, mdp: mdp)
        
        HomeView.user = newUser
        presentationMode.wrappedValue.dismiss()
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Nom", text: $nom)
                TextField("Prenom", text: $prenom)
                TextField("Mail", text: $mail)
                TextField("Mot de passe", text: $mdp)
//                TextField("Nom", $nom)
            }
            
            Button{
                inscription()
            } label: {
                Text("Valider l'inscription")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(.orange)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
