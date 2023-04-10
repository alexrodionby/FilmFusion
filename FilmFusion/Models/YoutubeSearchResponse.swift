//
//  YoutubeSearchResponse.swift
//  FilmFusion
//
//  Created by KODDER on 09.04.2023.
//

import UIKit

struct YoutubeSearchResponse: Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id: IdVideoElement
}

struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}
