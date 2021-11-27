//
//  NotSignView.swift
//  eBayMIAGE
//
//  Created by SAINT GERMAIN on 27/11/2021.
//

import SwiftUI

struct NotSignView: View {
    @State var selection: Int? = 0
    
    @EnvironmentObject var user: Utilisateur

    var body: some View {
        NavigationView {
            VStack {
                Text("Veuillez vous connecter pour continuer")
                
                Spacer()
                
                NavigationLink(destination: SignInView(dismissClosure: { user in
                    self.user.connectUser(user: user)
                }), tag: 1, selection: $selection) {
                    Button {
                        self.selection = 1
                    } label: {
                        Text("Se connecter")
                            .frame(minWidth: 0, maxWidth: .infinity)
                    }
                    .buttonStyle(OrangeButton())
                }
                .padding(.top)
                
                NavigationLink(destination: SignUpView(dismissClosure: { user in
                    self.user.connectUser(user: user)
                })) {
                    Text("Pas encore inscrit ?")
                }
                 
                Spacer()
            }
            .padding()
        }
    }
}
