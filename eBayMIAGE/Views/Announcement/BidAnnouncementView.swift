//
//  BidAnnouncement.swift
//  eBayMIAGE
//
//  Created by SAINT GERMAIN on 23/11/2021.
//

import Combine
import SwiftUI

struct BidAnnouncementView: View {
    
    var annonce: Annonce
    
    var timer = 0
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Annonce")
                .font(.title)
                .bold()
            
            Text("\(annonce.nom)")
            Text("\(annonce.description)")
            Text("Prix")
            
            
            if timer == 0 {
                AnnouncementEndedView(annonce: annonce)
            } else {
                AnnouncementStillInProgressView(annonce: annonce)
            }
            
            Spacer()
        }
    }
}

struct AnnouncementEndedView: View {
    
    var annonce: Annonce
    
    var body: some View {
        Text("nom, prénom gagnant")
        
        Text("Fixer un créneau")
    }
}

struct AnnouncementStillInProgressView: View {
    
    var annonce: Annonce
    
    @State var prix: String = "0"
    
    private func encherir() {
        print("cc jencheri")
    }
    
    var body: some View {
        VStack {
            Text("Temps restant")
            
            Text("Enchérir").bold()
            
            TextField("Prix de la nouvelle enchère", text: $prix)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
                .onReceive(Just(prix)) { newValue in
                    let filtered = newValue.filter { "0123456789".contains($0) }
                    if filtered != newValue {
                        self.prix = filtered
                    }
                }
            Button {
                encherir()
            } label: {
                Text("Proposer un prix")
            }
            
            Text("Liste historique des prix")
        }
    }
}
