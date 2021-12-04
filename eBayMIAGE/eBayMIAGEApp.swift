//
//  eBayMIAGEApp.swift
//  eBayMIAGE
//
//  Created by SAINT GERMAIN on 12/11/2021.
//

import SwiftUI


@main
struct eBayMIAGEApp: App {
    
    @ObservedObject var locationManager = LocationManager()
    
    init() {
        locationManager.requestLocation()
    }
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(locationManager)
        }
    }
}
