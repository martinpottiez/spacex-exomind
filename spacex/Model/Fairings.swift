//
//  Fairings.swift
//  spacex
//
//  Created by Martin on 08/07/2021.
//

import Foundation

struct Fairings: Hashable, Decodable {
    
    enum CodingKeys: String, CodingKey {
        case reused,
             recovered
    }
    var reused: Bool?
    var recovered: Bool?
}
