//
//  AppData.swift
//  Relief
//
//  Created by Alejandro Botana on 6/3/22.
//

import Foundation

class AppData {
    static let shared = AppData()
    var apiToken: String = ""
    var role: String = ""
    var imageProfile: String = ""
    var name: String = ""
    var created_at: String = ""
    var email: String = ""
    var address: String = ""
    var lat: Double = 0.0
    var long: Double = 0.0
    var description: String = ""
    var phone_number: String = ""
    var id: Int = 0

    
}
