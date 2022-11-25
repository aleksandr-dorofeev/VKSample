// ResponseFriend.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Friends list.
struct ResponseFriend: Decodable {
    let count: Int
    let items: [ItemFriend]
}
