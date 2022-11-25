// ResponseGroup.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Groups.
struct ResponseGroup: Decodable {
    let count: Int
    let items: [ItemGroup]
}
