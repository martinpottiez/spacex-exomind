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
             upcoming,
             success,
             details
        case dateUnix = "date_unix"
        case flightNumber = "flight_number"
    }
    var fairings: Fairings?
    var links: LaunchLinks?
    var success: Bool?
    var flightNumber: Int
    var name: String?
    var upcoming: Bool?
    var dateUnix: Int
    var details: String?
}
