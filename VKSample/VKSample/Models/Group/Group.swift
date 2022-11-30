// Group.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Groups the user is subscribed to.
@objcMembers
final class Group: Object, Decodable {
    dynamic var id: Int
    dynamic var name: String
    dynamic var avatar: String?

    // MARK: - CodingKeys enums.

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case avatar = "photo_100"
    }

    // MARK: - Public methods.

    override static func primaryKey() -> String? {
        "id"
    }
}
