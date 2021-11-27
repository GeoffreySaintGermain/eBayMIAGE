//
//  Profile.swift
//  eBayMIAGE
//
//  Created by SAINT GERMAIN on 16/11/2021.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var user: Utilisateur
    
    var body: some View {
        VStack {
            UserInformationView()
        }
    }
}

struct UserInformationView: View {
    
    @EnvironmentObject var user: Utilisateur
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack(alignment: .center) {
                Text("\(user.prenom) \(user.nom)")
                Text("photo ici")
            }
            
            Spacer()
            
            VStack(alignment: .leading) {
                Text("\(user.mail)")
                Text("\(user.identifiant)")
            }
            
            Spacer()
            
            DeconnectionButtonView()
                .padding()
                
            Spacer()
        }
    }
}

struct DeconnectionButtonView: View {
    
    @EnvironmentObject var user: Utilisateur
    
    private func deconnectUser() {
        user.deconnectUser()
    }
    
    var body: some View {
        VStack {
            Button() {
                deconnectUser()
            } label: {
                Text("Déconnexion")
                    .frame(minWidth: 0, maxWidth: .infinity)
            }
            .buttonStyle(RedButton())
            
        }
    }
}
