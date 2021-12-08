//
//  LocationManager.swift
//  eBayMIAGE
//
//  Created by SAINT GERMAIN on 04/12/2021.
//

import CoreLocation
import CoreLocationUI

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()

    @Published var location: CLLocationCoordinate2D?

    override init() {
        super.init()
        manager.delegate = self
    }

    func requestLocation() {
        manager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Swift.Error) {
        print("error:: (error)")        
    }
    
    func convertLatLongToAddress(latitude: Double, longitude: Double, completion: @escaping (CLPlacemark) -> ()) {
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: latitude, longitude: longitude)
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            // Place details
            guard let placeMark = placemarks?[0] else {
                print("find no placemarks")
                print(error?.localizedDescription ?? "")
                return
            }
            
            completion(placeMark)
        })        
    }
    
}
