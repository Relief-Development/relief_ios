//
//  User.swift
//  Relief
//
//  Created by Alejandro Botana on 6/3/22.
//
import Foundation
import MapKit

class UserAnnotation: NSObject, MKAnnotation {
    
    var user: User
    
    init(with user: User) {
        self.user = user
    }
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: user.lat ?? 0, longitude: user.long ?? 0)
    }
    
    var title: String? {
        user.name
    }
    
}

struct User: Codable {
    var name: String?
    var username: String?
    var email: String?
    var password: String?
    var image: String?
    var description: String?
    var role: String?
    var created_at: String?
    var address: String?
    //var phone_number: String?
    var lat: Double?
    var long: Double?

    

}
