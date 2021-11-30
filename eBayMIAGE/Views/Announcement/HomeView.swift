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
        AnnounceAPI().getAnnouncements(completion: { announcementsApi in
            myAnnouncements = announcementsApi.filter { $0.idUtilisateur == UserInformationDataStore.shared.id }
        })
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Vos annonces")
                .padding(.leading)
            
            List {
                ForEach(myAnnouncements, id: \.id) { announcement in
                    NavigationLink(destination: BidAnnouncementView(annonce: announcement, dismissClosure: {
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
    
    @State var timeLeft: Date = Date()
    
    init(announcement: Annonce) {
        self.announcement = announcement
        
//        let timeIntervalLeft = announcement.dateCreation.addingTimeInterval(Double(announcement.duree)).timeIntervalSinceReferenceDate
//
//        timeLeft = Date(timeIntervalSinceNow: timeIntervalLeft)
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
            Text("Vos enchères")
                .padding(.leading)
            
            List {
                ForEach(myAuctions, id: \.id) { announcement in
                    NavigationLink(destination: BidAnnouncementView(annonce: announcement, dismissClosure: {
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
