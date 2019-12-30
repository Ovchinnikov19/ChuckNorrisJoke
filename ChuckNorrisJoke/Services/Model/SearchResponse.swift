//
//  SearchResponse.swift
//  ChuckNorrisJoke
//
//  Created by Eduard Ovchinnikov on 30.12.2019.
//  Copyright © 2019 Eduard Ovchinnikov. All rights reserved.
//

import Foundation

struct SearchResponse: Decodable {
    var type: String
    var value: [Joke]
}

struct Joke: Decodable {
    var id: Int
    var joke: String
    var categories:[String]
}

