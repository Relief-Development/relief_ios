//
//  Response.swift
//  Relief
//
//  Created by Alejandro Botana on 6/3/22.
//

import Foundation

struct Response: Codable {
    var status: Int?
    var msg: String?
    var profile: [User]?
    var token: String?
    var image: String?
    var massages: [Massage]?
    var list: [User]?

    
}
