// News.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Type of news.
enum NewsType: String, Decodable {
    case wallPhoto
    case post
    case photo
}

/// News.
class News: Decodable {
    /// New's id.
    var id: Int?
    /// Date of news.
    var date: Int
    /// Identifier of the owner of the news.
    var sourceID: Int
    /// Text of news.
    var text: String?
    /// Avatar of the owner of the news, which is installed from the Friends model.
    var avatarPath: String?
    /// Name of the owner of the news, which is installed from the Friends model.
    var authorName: String?
    /// Attachments of the owner
    var attachments: [Attachments]?
    /// Comments for news.
    var comments: Comments?
    /// Likes for news.
    var likes: Likes?
    /// Reposts for news.
    var reposts: Reposts?
    /// Views for news.
    let views: Views?
    /// Type of Post.
    var postType: NewsType?

    private enum CodingKeys: String, CodingKey {
        case id
        case date
        case sourceID = "source_id"
        case text
        case comments
        case likes
        case reposts
        case views
        case attachments
    }
}
