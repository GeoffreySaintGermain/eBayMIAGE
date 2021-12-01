//
//  FindAnnouncement.swift
//  eBayMIAGE
//
//  Created by SAINT GERMAIN on 23/11/2021.
//

import SwiftUI

struct FindAnnouncements: View {
    
    @State var otherAnnouncementsNotBid: [Annonce] = []
    
    private func getAnnouncements() {
        AuctionAPI().getMyAuctions(completion: { announcements in
            AnnounceAPI().getAnnouncements(completion: { announcements in
                let otherAnnouncements = announcements.filter({ $0.idUtilisateur != UserInformationDataStore.shared.id })
                
                otherAnnouncementsNotBid = otherAnnouncements.filter({ otherAnnouncement in
                    otherAnnouncements.contains(where: { otherAnnouncement.id == $0.id  })
                })
            })
        })
        
        
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Enchères disponibles")
                    .padding(.leading)
                
                List {
                    ForEach(otherAnnouncementsNotBid, id: \.id) { announcement in
                        NavigationLink(destination: AnnouncementView(annonce: announcement, dismissClosure: {
                            getAnnouncements()
                        })) {
                            BidderRow(announcement: announcement)
                        }
                    }
                }
            }.onAppear(perform: {
                getAnnouncements()
            })
        }        
    }
}
