//
//  SignInView.swift
//  eBayMIAGE
//
//  Created by SAINT GERMAIN on 13/11/2021.
//

import SwiftUI

struct SignInView: View {
    @State var isSelectionActive: Bool = false
    
    @State var idUser: String = ""
    @State var password: String = ""
    
    private var fakeUser = Utilisateur(nom: "Stg", prenom: "Geoffrey", mail: "geoffrey.saint-germain@toulouse.miage.fr", mdp: "cc")
    
    private func connectUser() {
        
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Connexion")
                
                Form {
                    TextField("Nom d'utilisateur", text: $idUser)
                    TextField("Mot de passe", text: $password)
                }                
                
                Button {
                    connectUser()
                } label: {
                    Text("Connexion")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(.orange)
                }
                .padding(.top)
                
                Spacer()
                NavigationLink(destination: SignUpView()) {
                    Text("Pas encore inscrit ?")
                }
            }
            .padding()
        }
    }
}

struct NotSignView: View {
    
    @State var selection: Int? = 0
    
    var body: some View {
        NavigationView {
            VStack {                
                Text("Veuillez vous connecter pour continuer")
                
                Spacer()
                
                NavigationLink(destination: SignInView(), tag: 1, selection: $selection) {
                    Button {
                        self.selection = 1
                    } label: {
                        Text("Se connecter")
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(.orange)
                    }
                }
                .padding(.top)
                
                Spacer()
                NavigationLink(destination: SignUpView()) {
                    Text("Pas encore inscrit ?")
                }
            }
            .padding()
        }
    }
}