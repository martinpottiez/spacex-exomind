//
//  Launch.swift
//  spacex
//
//  Created by Martin on 05/07/2021.
//

import Foundation

struct Launch: Hashable, Decodable {
    
    struct Fairings: Hashable, Decodable {
        
        enum CodingKeys: String, CodingKey {
            case reused,
                 recovered
        }
        var reused: Bool?
        var recovered: Bool?
    }
    
    struct LaunchLinks: Hashable, Decodable {
        
        struct Flickr: Hashable, Decodable {
            enum CodingKeys: String, CodingKey {
                case original
            }
            var original: [String]?
        }
        
        struct Patch: Hashable, Decodable {
            var small: String?
            var large: String?
        }
        
        enum CodingKeys: String, CodingKey {
            case article,
                 wikipedia,
                 patch,
                 flickr,
                 _webcast = "webcast"
        }
        var patch: Patch?
        var flickr: Flickr?
        
        
        private var _webcast: String?
        
        
        
        var webcast: URL? {
            guard let url = _webcast else {
                return nil
            }
            return URL(string: url)
        }
        var article: URL?
        var wikipedia: URL?
    }
    
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
