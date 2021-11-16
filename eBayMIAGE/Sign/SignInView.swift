//
//  SignInView.swift
//  eBayMIAGE
//
//  Created by SAINT GERMAIN on 13/11/2021.
//

import SwiftUI

struct SignInView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var isSelectionActive: Bool = false
    
    @State var idUser: String = ""
    @State var password: String = ""
    
     var dismissClosure: (Utilisateur) -> Void
    
    init(dismissClosure: @escaping (Utilisateur) -> Void) {
        self.dismissClosure = dismissClosure
    }
    
    private var fakeUser = Utilisateur(nom: "Stg", prenom: "Geoffrey", mail: "geoffrey.saint-germain@toulouse.miage.fr", mdp: "cc")
    
    private func connectUser() {
        dismissClosure(fakeUser)
        presentationMode.wrappedValue.dismiss()
    }
    
    var body: some View {
        VStack {
            Spacer()
            TextField("Nom d'utilisateur", text: $idUser)
                .padding(.bottom)
            TextField("Mot de passe", text: $password)
            
            Button("Connexion") {
                connectUser()
            }
            .buttonStyle(OrangeButton())
            .padding(.top)
            
            Spacer()
            NavigationLink(destination: SignUpView()) {
                Text("Pas encore inscrit ?")
            }
        }
        .padding()
        .navigationTitle("Connexion")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct NotSignView: View {
    
    @State var selection: Int? = 0
    
    var dismissClosure: (Utilisateur) -> Void
    
    var body: some View {
        NavigationView {
            VStack {                
                Text("Veuillez vous connecter pour continuer")
                
                Spacer()
                
                NavigationLink(destination: SignInView(dismissClosure: { user in
                    dismissClosure(user)
                }), tag: 1, selection: $selection) {
                    Button {
                        self.selection = 1
                    } label: {
                        Text("Se connecter")
                    }
                    .buttonStyle(OrangeButton())
                }
                .padding(.top)
                
                Spacer()
            }
            .padding()
        }
    }
}
