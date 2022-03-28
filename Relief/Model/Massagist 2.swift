//
//  Massagist.swift
//  Relief
//
//  Created by Javier Eduardo Rodriguez Ardila on 4/2/22.
//

import Foundation
import MapKit

class Massagist: NSObject, MKAnnotation {
    var name: String?
    var serviceDescription: String?
    var lat: Double?
    var lng: Double?
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: lat ?? 0, longitude: lng ?? 0)
    }
    
    var title: String? {
        return name
    }
    
    var subtitle: String? {
        return serviceDescription
    }
    
}
