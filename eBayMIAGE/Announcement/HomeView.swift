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
            Divider()
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
            
            List {
                ForEach(announcements, id: \.id) { announcement in
                    AnnouncerRow(announcement: announcement)
                }
            }
        }
    }
}

struct AnnouncerRow: View {
    
    var announcement: Annonce
    
    var body: some View {
        HStack {
            Image(systemName: "1.square.fill")
            
            VStack(alignment: .leading) {
                HStack {
                    Text(announcement.nom)
                    Spacer()
                    Text("durée")
                }
                
                Text(announcement.prixPlanche)
            }
        }
    }
}

struct BidderView: View {
    
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
            Text("Vos enchères")
            
            List {
                ForEach(announcements, id: \.id) { announcement in
                    BidderRow(announcement: announcement)
                }
            }
        }
    }
}

struct BidderRow: View {
    
    var announcement: Annonce
    
    var body: some View {
        HStack {
            Image(systemName: "1.square.fill")
            
            VStack(alignment: .leading) {
                Text(announcement.nom)
                Text(announcement.description)
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
