//
//  BidAnnouncementView.swift
//  eBayMIAGE
//
//  Created by SAINT GERMAIN on 23/11/2021.
//

import Combine
import SwiftUI

struct AnnouncementView: View {
                
    var annonce: Annonce
    
    var dismissClosure: () -> Void
    
    var timer = 0
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Annonce")
                .font(.title)
                .bold()
            
            Text("\(annonce.nom)")
            Text("\(annonce.description)")
            Text("Prix")
            
            Divider()
//            if timer == 0 {
//                AnnouncementEndedView(annonce: annonce)
//            } else {
            AnnouncementStillInProgressView(annonce: annonce)
//            }
            

            
            Spacer()
        }.padding()
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
    
    @Environment(\.presentationMode) var presentationMode
    
    var annonce: Annonce
    
    @State var historic: [Enchere] = []
    
    @State var prix: String = "0"
    
    private func getHistoric() {
        AuctionAPI().getHistoricAuctions(annonceId: annonce.id, completion: { auctions in
            historic = auctions
        })
    }
    
    private func encherir() {
        let prixDouble = Double(prix) ?? 0.0
        
        if checkInput(prixDouble: prixDouble) {
            
            let newAuction = Enchere(prix: Double(prix) ?? 0.0)
            
            AuctionAPI().bidOnAnnoucement(auction: newAuction, announcement: annonce, completion: { isOk in
                if isOk {
                    presentationMode.wrappedValue.dismiss()
                }
                else {
                    print("error")
                }
            })
        } else {
            print("error input")
        }
    }
    
    private func checkInput(prixDouble: Double) -> Bool {
        var inputIsOk = true
        
        if  prixDouble == 0.0 || (historic.count == 0 && historic.contains(where: { $0.prix > prixDouble })) {
            inputIsOk = false
        }
        
        return inputIsOk
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Spacer()
                Text("Temps restant")
                Spacer()
            }
            
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
                    .frame(minWidth: 0, maxWidth: .infinity)
            }
            .buttonStyle(OrangeButton())
            .padding(.top)
            
            Text("Liste historique des prix")
            
            List {
                ForEach(historic, id: \.id) { auction in
                    HistoricRowView(auction: auction)
                        .ignoresSafeArea()
                }
            }
        }.onAppear {
            getHistoric()
        }
    }
}

struct HistoricRowView: View {
    
    var auction: Enchere
    
    var body: some View {
        VStack {
            Text("\(auction.id ?? 0)")
            Text("\(auction.dateFormatted)")
            Text("\(auction.prix, specifier: "%.2f")")
        }
    }
}
