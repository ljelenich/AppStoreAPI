//
//  MusicItem.swift
//  AppleSearch
//
//  Created by LAURA JELENICH on 9/24/20.
//

import Foundation

// The top level object is where our results are stored
struct MusicTopLevelObject: Decodable {
    let results: [MusicTrack]
}

struct MusicTrack: Decodable {
    let artistName: String
    let trackName: String
    let artworkUrl100: URL?
}
