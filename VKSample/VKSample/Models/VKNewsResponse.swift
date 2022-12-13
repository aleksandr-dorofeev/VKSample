// VKNewsResponse.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Response for items.
struct VKNewsResponse: Decodable {
    /// List of news.
    var news: [News]
    /// List of friend's news.
    var friends: [Friend]
    /// List of group's news.
    var groups: [Group]
    /// Data for nextPage.
    var nextPage: String?

    enum CodingKeys: String, CodingKey {
        case response
        case groups
        case profiles
        case items
        case nextPage = "next_from"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: VKNewsResponse.CodingKeys.self)
        let responseContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .response)
        friends = try responseContainer.decode([Friend].self, forKey: .profiles)
        news = try responseContainer.decode([News].self, forKey: .items)
        groups = try responseContainer.decode([Group].self, forKey: .groups)
        if responseContainer.contains(.nextPage) {
            nextPage = try responseContainer.decode(String.self, forKey: .nextPage)
        }
    }
}
