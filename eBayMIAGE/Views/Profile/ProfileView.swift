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
        VStack(alignment: .leading) {
            Spacer()
            
            HStack(alignment: .center) {
                Spacer()
                Text("photo ici")
                Spacer()
            }
            
            Divider()
            
            Group {
                HStack {
                    Image(systemName: "person.circle")
                        .padding(.leading)
                    Text("\(user.identifiant ?? "")")
                }
                HStack {
                    Image(systemName: "pencil.circle")
                        .padding(.leading)
                    Text("\(user.prenom) \(user.nom)")
                }
                HStack {
                    Image(systemName: "envelope.circle")
                        .padding(.leading)
                    Text("\(user.mail ?? "")")
                }
            }
                       
            Divider()
            Spacer()
            
            DeconnectionButtonView()
                .padding()
        }.padding()
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
