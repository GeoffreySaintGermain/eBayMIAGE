//
//  TabView.swift
//  eBayMIAGE
//
//  Created by SAINT GERMAIN on 16/11/2021.
//

import SwiftUI

struct MainTabView: View {
    @StateObject var user: Utilisateur = UtilisateurDataStore.shared
     
    var body: some View {
        TabView{
            if user.identifiant != "" {
                HomeView()
                    .tabItem {
                        Image(systemName: "1.square.fill")
                        Text("DashBoard")
                    }
                
                FindAnnouncements()
                    .tabItem {
                        Image(systemName: "1.square.fill")
                        Text("Enchères")
                    }                
                
                ProfileView()
                    .tabItem {
                        Image(systemName: "1.square.fill")
                        Text("Profil")
                    }
            } else {
                NotSignView()
            }
        }
        .environmentObject(user)
        .font(.headline)
    }
}
