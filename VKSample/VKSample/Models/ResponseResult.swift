// ResponseResult.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Result request.
struct ResponseResult<T: Decodable>: Decodable {
    let items: [T]

    enum CodingKeys: String, CodingKey {
        case response
        case items
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let responseContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .response)
        items = try responseContainer.decode([T].self, forKey: .items)
    }
}
