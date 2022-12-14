// Photo.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// User's photo.
@objcMembers
final class Photo: Object, Decodable {
    // MARK: - Public properties.

    /// Photo type.
    dynamic var type = String()
    /// Photo url.
    dynamic var url = String()
    /// Photo owner id.
    dynamic var ownerID = Int()
    /// Photo id.
    dynamic var id = Int()
    /// Photo height
    var height = Int()
    /// Photo width.
    var width = Int()

    var aspectRatio: CGFloat {
        CGFloat(height) / CGFloat(width)
    }

    // MARK: - CodingKeys enums.

    enum CodingKeys: String, CodingKey {
        case sizes
        case id
        case ownerID = "owner_id"
    }

    enum SizeKeys: String, CodingKey {
        case type
        case url
        case height
        case width
    }

    // MARK: - Initializers.

    required convenience init(from decoder: Decoder) throws {
        self.init()
        let sizeContainer = try decoder.container(keyedBy: CodingKeys.self)
        let ownerIDContainer = try decoder.container(keyedBy: CodingKeys.self)
        ownerID = try ownerIDContainer.decode(Int.self, forKey: .ownerID)
        let photoIDContainer = try decoder.container(keyedBy: CodingKeys.self)
        id = try photoIDContainer.decode(Int.self, forKey: .id)
        var sizeValues = try sizeContainer.nestedUnkeyedContainer(forKey: .sizes)
        while !sizeValues.isAtEnd {
            let reviewCountContainer = try sizeValues.nestedContainer(keyedBy: SizeKeys.self)
            type = try reviewCountContainer.decode(String.self, forKey: .type)
            url = try reviewCountContainer.decode(String.self, forKey: .url)
            height = try reviewCountContainer.decode(Int.self, forKey: .height)
            width = try reviewCountContainer.decode(Int.self, forKey: .width)
        }
    }

    // MARK: - Public methods.

    override static func primaryKey() -> String? {
        "id"
    }
}
