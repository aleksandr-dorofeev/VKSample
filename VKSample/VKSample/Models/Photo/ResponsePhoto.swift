// ResponsePhoto.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// User's photos.
struct ResponsePhoto: Decodable {
    let count: Int
    let items: [ItemPhoto]
}
