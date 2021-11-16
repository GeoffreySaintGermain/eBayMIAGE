//
//  ResumeAnnonce.swift
//  eBayMIAGE
//
//  Created by SAINT GERMAIN on 13/11/2021.
//

import SwiftUI

struct HomeView: View {
    
    @State var user: Utilisateur = Utilisateur.shared
    
    var body: some View {
        VStack {
            if let _ = user.id {
                Text("Bonjour \(user.nom ?? "")")
                YourAnnouncementsView()
                Spacer()
            } else {
                NotSignView(dismissClosure: { user in
                    Utilisateur.shared = user
                    self.user = user
                })
            }
        }        
    }
}

struct YourAnnouncementsView: View {
    
    var body: some View {
        VStack {
            AnnouncerView()
            Spacer()
            BidderView()
        }
    }
}

struct AnnouncerView: View {
    
    var announcements: [Annonce]?
    
    var body: some View {
        Text("Vos annonces")
        
        if let announcements = announcements {
            ForEach(announcements, id: \.id) { announcement in
                NavigationLink(destination: AnnouncementView()) {
                    Text("\(announcement.nom)")
                }
            }            
        }
    }
}

struct BidderView: View {
    
    var announcements: [Annonce]?
    
    var body: some View {
        Text("Vos enchères")
        
        if let announcements = announcements {
            ForEach(announcements, id: \.id) { announcement in
                NavigationLink(destination: AnnouncementView()) {
                    Text("\(announcement.nom)")
                }
            }
        }
    }
}

struct DeconnectButton: View {
    
    var body: some View {
        
        Button("Déconnexion") {
            
        }
        .buttonStyle(RedButton())
    }
    
}
