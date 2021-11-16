//
//  ResumeAnnonce.swift
//  eBayMIAGE
//
//  Created by SAINT GERMAIN on 13/11/2021.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var user: Utilisateur
    
    var body: some View {
        VStack(alignment: .leading) {
            YourAnnouncementsView()
        }                        
    }
}

struct YourAnnouncementsView: View {
    
    var body: some View {
        VStack(alignment: .leading) {
            AnnouncerView()
            Spacer()
            BidderView()
        }
    }
}

struct AnnouncerView: View {
    
    var announcements: [Annonce]
    
    init() {
        announcements = []
        
        let count = 1...10
        
        for _ in count {
            let newAnnounce = Annonce(nom: "test", description: "descriptionTest", prixPlanche: "10", etat: 0, duree: Date.now, photo: "")
            
            self.announcements.append(newAnnounce)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
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
}

struct BidderView: View {
    
    var announcements: [Annonce]?
    
    var body: some View {
        VStack(alignment: .leading) {
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
}

struct DeconnectButton: View {
    
    var body: some View {
        
        Button("Déconnexion") {
            
        }
        .buttonStyle(RedButton())
    }
    
}
