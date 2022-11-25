// Group.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Response about groups.
struct Group: Decodable {
    let response: ResponseGroup
}

/// Groups.
struct ResponseGroup: Decodable {
    let count: Int
    let items: [ItemGroup]
}

/// Groups the user is subscribed to.
final class ItemGroup: Object, Decodable {
    @objc dynamic var id: Int
    @objc dynamic var name: String
    @objc dynamic var avatar: String?

    // MARK: - CodingKeys enums.

    enum CodingKeys: String, CodingKey {
        case id, name
        case avatar = "photo_100"
    }
}
