// VKResponse.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Response for items.
struct VKResponse<T: Decodable>: Decodable {
    var count: Int
    var items: [T]

    enum CodingKeys: String, CodingKey {
        case response
        case count
        case items
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: VKResponse<T>.CodingKeys.self)
        let responseContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .response)
        count = try responseContainer.decode(Int.self, forKey: .count)
        items = try responseContainer.decode([T].self, forKey: .items)
    }
}
