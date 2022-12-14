// Photo.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// User's photo.
@objcMembers
final class Photo: Object, Decodable {
    // MARK: - Public properties.

    dynamic var type = String()
    dynamic var url = String()
    dynamic var ownerID = Int()
    dynamic var id = Int()
    var height = Int()
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
