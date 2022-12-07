// News.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Type of news.
enum NewsType: String, Decodable {
    case wallPhoto
    case post
}

/// News.
class News: Decodable {
    var id: Int?
    var date: Int
    var sourceID: Int
    var text: String?
    var avatarPath: String?
    var authorName: String?
    var postType: NewsType?

    private enum CodingKeys: String, CodingKey {
        case id
        case date
        case sourceID = "source_id"
        case text
    }
}
