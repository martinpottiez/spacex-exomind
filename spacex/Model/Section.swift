//
//  Section.swift
//  spacex
//
//  Created by Martin on 05/07/2021.
//

import Foundation

/*struct Section: Hashable {
    
    let id: Int
    let title: String
    let category: String
    var items: [Launch]
}*/

enum Section: String, CaseIterable {
    case upcoming = "Upcoming Flight"
    case past = "Old Flight "
}
