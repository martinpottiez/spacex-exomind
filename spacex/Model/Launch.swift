//
//  Launch.swift
//  spacex
//
//  Created by Martin on 05/07/2021.
//

import Foundation

struct Launch: Hashable, Decodable {
    
    enum CodingKeys: String, CodingKey, Hashable {
        case name,
             links,
             upcoming
        case dateUnix = "date_unix"
    }
    var links: LaunchLinks?
    var name: String?
    var upcoming: Bool?
    var dateUnix: Int
}
