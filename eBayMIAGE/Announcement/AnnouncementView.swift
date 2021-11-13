//
//  ResumeAnnonce.swift
//  eBayMIAGE
//
//  Created by SAINT GERMAIN on 13/11/2021.
//

import SwiftUI

struct AnnouncementView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct Announcer: View {
    
    var announcements: [Annonce]?
    
    var body: some View {
        if let announcements = announcements {
            ForEach(announcements, id: \.id) { _ in
                Text("")
            }
        }
    }
}

struct Bidder: View {
    
    var body: some View {
        Text("hi")
    }
}
