// Session.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Information about current session of user.
struct Session {
    static let shared = Session()
    var token = String()
    var userID = Int()
    private init() {}
}
