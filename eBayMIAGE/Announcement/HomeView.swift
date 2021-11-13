//
//  ResumeAnnonce.swift
//  eBayMIAGE
//
//  Created by SAINT GERMAIN on 13/11/2021.
//

import SwiftUI

struct HomeView: View {
    
    public static var user: Utilisateur?
    
    var body: some View {
        VStack {
            if let user = HomeView.user {
                Text("Bonjour \(user.nom)")
                YourAnnouncementsView()
                Spacer()
            } else {
                NotSignView()
            }
        }        
    }
}

struct YourAnnouncementsView: View {
    
    var body: some View {
        HStack(alignment: .center) {
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
