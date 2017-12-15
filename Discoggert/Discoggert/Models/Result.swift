//
//  Wantlist.swift
//  Discoggert
//
//  Created by Timo den Hartog on 06-12-17.
//  Copyright © 2017 Timo den Hartog. All rights reserved.
//

import Foundation

struct Result: Codable {
    var ID: String
    var title: String
    var year: String
    var genre: String

    init(ID: String, title: String, year: String, genre: String) {
        self.ID = ID
        self.title = title
        self.year = year
        self.genre = genre
    }

}

struct resultsArray {
    let resultsArray: [Result]
}


