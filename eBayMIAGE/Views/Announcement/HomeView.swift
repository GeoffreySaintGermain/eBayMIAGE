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
                Spacer()
            }
        }
        .ignoresSafeArea()
    }
}

struct YourAnnouncementsView: View {
    
    var body: some View {
        VStack(alignment: .leading) {
            AnnouncerView()
            BidderView()
        }
    }
}

struct AnnouncerView: View {
    
    @State var myAnnouncements: [Annonce] = []
    
    private func getAnnouncements() {
        AnnounceAPI().getMyAnnouncements(completion: { announcementsApi in
            myAnnouncements = announcementsApi
        })
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Vos annonces")
                .padding(.leading)
            
            List {
                ForEach(myAnnouncements, id: \.id) { announcement in
                    NavigationLink(destination: AnnouncementView(announcement: announcement, dismissClosure: {
                        getAnnouncements()
                    })) {
                        AnnouncerRowView(announcement: announcement)
                    }
                }
                AddAnnouncementRowView(dismissClosure: {
                    getAnnouncements()
                })
            }
        }.onAppear {
            getAnnouncements()
        }
    }
}

struct AnnouncerRowView: View {
    
    var announcement: Annonce
    
    var body: some View {
        HStack {
            if let announcementPhoto = announcement.photoFrom64Encoded {
                announcementPhoto
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
            } else {
                Image(systemName: "1.square.fill")                    
            }
            
            VStack(alignment: .leading) {
                HStack {
                    Text(announcement.nom)
                    Spacer()
                    if announcement.endDate > Date.now {
                        Text(announcement.endDate, style: .timer)
                    } else {
                        Text("Ench??re termin??e")
                    }
                }
                
                Text("\(announcement.prixPlanche, specifier: "%.2f")???")
            }
        }
    }
}

struct AddAnnouncementRowView: View {
    
    @State private var showingSheet = false
    
    var dismissClosure: () -> Void
    
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
            NewAnnouncementSheetView(dismissClosure: {
                dismissClosure()
            })
        }
    }
}

struct BidderView: View {
    
    @State var myAuctions: [Annonce] = []
    
    private func getMyAuctions() {
        AuctionAPI().getMyAuctions(completion: { annoucements in
            myAuctions = annoucements
        })
    }
        
    var body: some View {
        VStack(alignment: .leading) {
            Text("Vos ench??res")
                .padding(.leading)
            
            List {
                ForEach(myAuctions, id: \.id) { announcement in
                    NavigationLink(destination: AnnouncementView(announcement: announcement, dismissClosure: {
                        getMyAuctions()
                    })) {
                        BidderRow(announcement: announcement)
                    }
                }
            }
        }.onAppear {
            getMyAuctions()
        }
    }
}

struct BidderRow: View {
    
    var announcement: Annonce
    
    var body: some View {
        HStack {
            if let announcementPhoto = announcement.photoFrom64Encoded {
                announcementPhoto
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
            } else {
                Image(systemName: "1.square.fill")                    
            }
            
            VStack(alignment: .leading) {
                HStack {
                    Text(announcement.nom)
                    Spacer()
                    if announcement.endDate > Date.now {
                        Text(announcement.endDate, style: .timer)
                    } else {
                        Text("Ench??re termin??e")
                    }                    
                }
                
                Text("\(announcement.prixPlanche, specifier: "%.2f")???")
            }
        }
    }
}

struct DeconnectButton: View {
    
    var body: some View {
        
        Button("D??connexion") {
            
        }
        .buttonStyle(RedButton())
    }
    
}
