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
            if user.isLogged {
                HomeView()
                    .tabItem {
                        Image(systemName: "list.dash")
                        Text("DashBoard")
                    }
                
                FindAnnouncements()
                    .tabItem {
                        Image(systemName: "plus.circle")
                        Text("Enchères")
                    }                
                
                ProfileView()
                    .tabItem {
                        Image(systemName: "person")
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
