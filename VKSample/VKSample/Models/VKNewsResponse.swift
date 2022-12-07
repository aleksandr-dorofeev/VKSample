// VKNewsResponse.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Response for items.
struct VKNewsResponse: Decodable {
    var news: [News]
    var friends: [Friend]
    var groups: [Group]

    enum CodingKeys: String, CodingKey {
        case response
        case groups
        case profiles
        case items
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: VKNewsResponse.CodingKeys.self)
        let responseContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .response)
        friends = try responseContainer.decode([Friend].self, forKey: .profiles)
        news = try responseContainer.decode([News].self, forKey: .items)
        groups = try responseContainer.decode([Group].self, forKey: .groups)
    }
}
