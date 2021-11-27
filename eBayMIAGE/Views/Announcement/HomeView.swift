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
        NavigationView {
            VStack(alignment: .leading) {
                YourAnnouncementsView()
            }
        }                             
    }
}

struct YourAnnouncementsView: View {
    
    var body: some View {
        VStack(alignment: .leading) {
            AnnouncerView()
            BidderView()
        }.padding()
    }
}

struct AnnouncerView: View {
    
    @State var announcements: [Annonce] = []
    
    private func addAnouncement(newAnnouncement: Annonce) {
        announcements.append(newAnnouncement)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Vos annonces")
            
            List {
                ForEach(announcements, id: \.id) { announcement in
                    NavigationLink(destination: BidAnnouncementView(annonce: announcement)) {
                        AnnouncerRowView(announcement: announcement)
                    }
                }
                AddAnnouncementRowView(dismissClosure: { announcement in
                    addAnouncement(newAnnouncement: announcement)
                })
            }
        }
    }
}

struct AnnouncerRowView: View {
    
    var announcement: Annonce
    
    @State var timeLeft: Date = Date()
    
    init(announcement: Annonce) {
        self.announcement = announcement
        
        let timeIntervalLeft = announcement.dateCreation.addingTimeInterval(Double(announcement.duree)).timeIntervalSinceReferenceDate
        
        timeLeft = Date(timeIntervalSinceNow: timeIntervalLeft)
    }
        
    var body: some View {
        HStack {
            Image(systemName: "1.square.fill")
            
            VStack(alignment: .leading) {
                HStack {
                    Text(announcement.nom)
                    Spacer()
                    Text(timeLeft, style: .timer)
                }
                
                Text("\(announcement.prixPlanche, specifier: "%.2f")€")
            }
        }
    }
}

struct AddAnnouncementRowView: View {
    
    @State private var showingSheet = false
    
    var dismissClosure: (Annonce) -> Void
    
    var body: some View {
        HStack {
            Image(systemName: "plus.square")
            
            VStack(alignment: .leading) {
                Text("Ajouter une annonce")
            }
        }
        .onTapGesture {
            showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            NewAnnouncementSheetView(dismissClosure: { announcement in
                dismissClosure(announcement)
            })
        }
    }
}

struct BidderView: View {
    
    var announcements: [Annonce]
    
    init() {
        announcements = []
        
        let count = 1...4
        let defaultDuration = 300
        
        for _ in count {
            let newAnnounce = Annonce(nom: "test", description: "descriptionTest", prixPlanche: 10, duree: defaultDuration, photo: "")
            
            self.announcements.append(newAnnounce)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Vos enchères")
            
            List {
                ForEach(announcements, id: \.id) { announcement in
                    NavigationLink(destination: BidAnnouncementView(annonce: announcement)) {
                        BidderRow(announcement: announcement)
                    }
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
                HStack {
                    Text(announcement.nom)
                    Spacer()
                    Text("durée")
                }
                
                Text("prix")
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