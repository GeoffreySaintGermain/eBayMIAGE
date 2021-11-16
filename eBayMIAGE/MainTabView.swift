//
//  TabView.swift
//  eBayMIAGE
//
//  Created by SAINT GERMAIN on 16/11/2021.
//

import SwiftUI

struct MainTabView: View {
    @StateObject var user: Utilisateur = Utilisateur.shared
    
    var body: some View {
        TabView{
            if user.isLogged {
                HomeView()
                    .tabItem {
                        Image(systemName: "1.square.fill")
                        Text("DashBoard")
                    }
                
                Text("2")
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
