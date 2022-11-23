// Session.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Information about current session of user.
struct Session {
    // MARK: - Static propreties.

    static var shared = Session()

    // MARK: - Public properties.

    var token = String()
    var userID = Int()

    // MARK: - Life cycle.

    private init() {}
}
