//
//  FindAnnouncement.swift
//  eBayMIAGE
//
//  Created by SAINT GERMAIN on 23/11/2021.
//

import SwiftUI

struct FindAnnouncements: View {
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
            Text("Enchères disponibles")
            
            List {
                ForEach(announcements, id: \.id) { announcement in
                    BidderRow(announcement: announcement)
                }
            }
        }
    }
}
