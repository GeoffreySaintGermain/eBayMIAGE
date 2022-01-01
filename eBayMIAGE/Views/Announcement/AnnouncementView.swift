//
//  BidAnnouncementView.swift
//  eBayMIAGE
//
//  Created by SAINT GERMAIN on 23/11/2021.
//

import Combine
import CoreLocation
import SwiftUI

struct AnnouncementView: View {
                
    var announcement: Annonce
    
    @EnvironmentObject var locationManager: LocationManager
    
    var dismissClosure: () -> Void
    
    @State var placemark: CLPlacemark?
    
    private func getGeoLocalisation() {
        guard let longitude = Double(announcement.longitude ?? "") else {
            print("error get longitude")
            return
        }
        
        guard let latitude = Double(announcement.latitude ?? "") else {
            print("error get latitude")
            return
        }
        
        locationManager.convertLatLongToAddress(latitude: latitude, longitude: longitude) { placemark in
            self.placemark = placemark
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Annonce")
                .font(.title)
                .bold()
            
            HStack {
                Spacer()
                announcement.photoFrom64Encoded?
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                Spacer()
            }
            
            Text("\(announcement.nom)")
            Text("\(announcement.description)")
            Text("Prix initial : \(announcement.prixPlanche, specifier: "%2.f")€")
            Group {
                Text("Lieu l'annonce :")
                if let placemark = self.placemark {
                    Text("\t\(placemark.locality ?? "Ville inconnu")")
                    Text("\t\(placemark.postalCode ?? "Code Postal inconnu")")
                    Text("\t\(placemark.country ?? "Pays inconnu")")
                } else {
                    Text("Emplacement inconnu")
                }
            }
            
            Divider()
            
            if announcement.endDate <= Date.now {
                AnnouncementEndedView(announcement: announcement)
            } else {
                AnnouncementStillInProgressView(announcement: announcement)
            }
                        
            Spacer()
        }
        .onAppear {
            getGeoLocalisation()
        }
        .padding()
    }
}

struct AnnouncementStillInProgressView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var announcement: Annonce
    
    @State var historic: [Enchere] = []
    
    @State var prix: String = "0"
    
    @State private var run = true
    
    private func getHistoric() {
        AuctionAPI().getHistoricAuctions(annonceId: announcement.id, completion: { auctions in
            historic = auctions
        })
    }
    
    private func encherir() {
        let prixDouble = Double(prix) ?? 0.0
        
        if checkInput() {
            
            let newAuction = Enchere(prix: Double(prix) ?? 0.0)
            
            AuctionAPI().bidOnAnnoucement(auction: newAuction, announcement: announcement, completion: { isOk in
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
    
    private func checkInput() -> Bool {
        var inputIsOk = true
        let prixDouble = Double(prix) ?? 0.0
        
        if  prixDouble <= announcement.prixPlanche || (historic.count > 0 && historic.contains(where: { $0.prix >= prixDouble })) {
            inputIsOk = false
        }
        return inputIsOk
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Spacer()
                if announcement.endDate > Date.now {
                    Text(announcement.endDate, style: .timer)
                } else {
                    Text("Enchère terminée")
                }
                Spacer()
            }
            
            if announcement.idUtilisateur != UserInformationDataStore.shared.id {
                Text("Enchérir").bold()
                
                TextField("Prix de la nouvelle enchère", text: $prix)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .background(
                        RoundedRectangle(cornerRadius: 5.0)
                            .stroke(checkInput() ? Color.green : Color.red, lineWidth: 2.0)
                    )
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
            }
            
            Divider()
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

struct AnnouncementEndedView: View {
    
    var announcement: Annonce
    
    @State var winner: Utilisateur?
    
    private func getWinner() {
        AuctionAPI().getWinner(announce: announcement) { user in
            winner = user
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if let winner = winner {
                WinnerView(winner: winner)
                                
                if announcement.idUtilisateur == UserInformationDataStore.shared.id {
                    Divider()
                    GetAppointmentView(announcement: announcement)
                }
                
                if winner.id == UserInformationDataStore.shared.id {
                    GetAppointmentWinnerView(announcement: announcement)
                }
                    
            } else {
                Text("Aucun gagnant lors de cette enchère")
            }
        }.onAppear {
            getWinner()
        }
    }
}

struct WinnerView: View {
    
    @EnvironmentObject var locationManager: LocationManager
    
    @State var winner: Utilisateur
    
    @State var placemark: CLPlacemark?
    
    private func getGeoLocalisation() {
        guard let longitude = Double(winner.longitude) else {
            print("error get longitude")
            return
        }
        
        guard let latitude = Double(winner.latitude) else {
            print("error get latitude")
            return
        }
        
        locationManager.convertLatLongToAddress(latitude: latitude, longitude: longitude) { placemark in
            self.placemark = placemark
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Gagnant de l'enchère :")
            Text("\(winner.nom), \(winner.prenom)")
        }
    }
}

struct GetAppointmentWinnerView: View {
    
    @State var announcement: Annonce
    
    var body: some View {
        VStack(alignment: .leading) {
            if let announcementDateLivraison = announcement.dateLivraisonFormatted {
                Divider()
                Text("Date de rendez vous")
                Text(announcementDateLivraison, style: .date)
                    .environment(\.locale, Locale(identifier: "fr"))
            }
        }
    }
}

struct GetAppointmentView: View {
    
    @State private var selectedDate = Date()
    
    @State var announcement: Annonce
    
    @State var appointment: Appointment?
    
    private func validateDateAppointment() {
        let appointment = Appointment(idAnnouncement: announcement.id, dateAppointment: selectedDate)
        
        AppointmentAPI().fixAppointment(appointment: appointment) { isOk in
            if isOk {
                AnnounceAPI().getAnnouncement(idAnnouncement: announcement.id) { announcment in
                    self.announcement = announcment
                }
            }
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            if announcement.dateLivraison != nil {
                Text("Date du rendez vous")
                
                if let announcementDateLivraison = announcement.dateLivraisonFormatted {
                    Text(announcementDateLivraison, style: .date)
                        .environment(\.locale, Locale(identifier: "fr"))
                }
            } else {
                DatePicker("Date de rendez vous", selection: $selectedDate, displayedComponents: .date)
                    .environment(\.locale, Locale.init(identifier: "fr"))
                
                Button {
                    validateDateAppointment()
                } label: {
                    Text("Prendre le rendez vous")
                        .frame(minWidth: 0, maxWidth: .infinity)
                }
                .buttonStyle(OrangeButton())                
            }
        }
    }
}

struct HistoricRowView: View {
    
    var auction: Enchere
    
    var body: some View {
        VStack(alignment: .leading){
            Text("\(auction.dateFormatted, style: .date) \(auction.dateFormatted, style: .time)")
                .environment(\.locale, Locale.init(identifier: "fr"))
            Text("\(auction.prix, specifier: "%.2f")€")
        }
    }
}
