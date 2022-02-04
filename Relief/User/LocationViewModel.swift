//
//  LocationViewModel.swift
//  Relief
//
//  Created by Javier Eduardo Rodriguez Ardila on 3/2/22.
//

import Foundation
import CoreLocation

final class LocationViewModel: NSObject{
    private let locationManager: CLLocationManager = .init()
    
    override init(){
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }
    
}
extension LocationViewModel: CLLocationManagerDelegate{
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        print("Location \(location)")
    }
}
