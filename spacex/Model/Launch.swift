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
            case patch,
                 flickr
            case _article = "article"
            case _webcast = "webcast"
            case _wikipedia = "wikipedia"
            case youtubeId = "youtube_id"
        }
        var patch: Patch?
        var flickr: Flickr?
        var youtubeId: String?
        
        private var _article: String?
        private var _webcast: String?
        private var _wikipedia: String?
        
        
        var webcast: URL? {
            guard let url = _webcast else {
                return nil
            }
            return URL(string: url)
        }
        
        var article: URL? {
            guard let url = _article else {
                return nil
            }
            return URL(string: url)
        }
        
        var wikipedia: URL? {
            guard let url = _wikipedia else {
                return nil
            }
            return URL(string: url)
        }
    }
    
    enum CodingKeys: String, CodingKey, Hashable {
        case fairings,
             name,
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
