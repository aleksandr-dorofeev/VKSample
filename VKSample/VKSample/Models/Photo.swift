// Photo.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Response about of user's photo.
struct Photo: Decodable {
    let response: ResponsePhoto
}

/// User's photos.
struct ResponsePhoto: Decodable {
    let count: Int
    let items: [ItemPhoto]
}

/// User's photo.
final class ItemPhoto: Object, Decodable {
    @objc dynamic var type = String()
    @objc dynamic var url = String()

    // MARK: - CodingKeys enums.

    enum CodingKeys: String, CodingKey {
        case sizes
    }

    enum SizeKeys: String, CodingKey {
        case type
        case url
    }

    // MARK: - Initializers.

    required convenience init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        var sizeValues = try values.nestedUnkeyedContainer(forKey: .sizes)
        while !sizeValues.isAtEnd {
            let reviewCountContainer = try sizeValues.nestedContainer(keyedBy: SizeKeys.self)
            type = try reviewCountContainer.decode(String.self, forKey: .type)
            url = try reviewCountContainer.decode(String.self, forKey: .url)
        }
    }
}
