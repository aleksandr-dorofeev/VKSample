// Friend.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Friend.
@objcMembers
final class Friend: Object, Decodable {
    // MARK: - Public properties.

    dynamic var id: Int
    dynamic var firstName: String
    dynamic var lastName: String
    dynamic var avatar: String?

    // MARK: - CodingKeys enums.

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar = "photo_100"
    }

    // MARK: - Public methods.

    override static func primaryKey() -> String? {
        "id"
    }
}
