//
//  Buttons.swift
//  eBayMIAGE
//
//  Created by SAINT GERMAIN on 14/11/2021.
//

import SwiftUI

struct OrangeButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(.orange)
            .foregroundColor(.white)
            .clipShape(Capsule())
    }
}

struct RedButton: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(.white)
            .foregroundColor(.red)
            .clipShape(Capsule())
    }
}
