//
//  Flickr.swift
//  spacex
//
//  Created by Martin on 08/07/2021.
//

import Foundation

struct Flickr: Hashable, Decodable {
    enum CodingKeys: String, CodingKey {
        case original
    }
    var original: [String]?
}
