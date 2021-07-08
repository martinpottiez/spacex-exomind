//
//  LaunchLinks.swift
//  spacex
//
//  Created by Martin on 05/07/2021.
//

import Foundation

struct LaunchLinks: Hashable, Decodable {
    enum CodingKeys: String, CodingKey {
        case article,
             wikipedia,
             patch,
             flickr
        case youtubeId = "youtube_id"
    }
    var patch: Patch?
    var flickr: Flickr?
    var youtubeId: String?
    var article: String?
    var wikipedia: String?
}
