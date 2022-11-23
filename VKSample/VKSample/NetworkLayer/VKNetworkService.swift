// VKNetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Network interface for VK API.
protocol VKNetworkServiceProtocol {
    func fetchFriends(userIDText: String)
    func fetchPhotoUser(ownerID: Int)
    func fetchUsersGroups(userIDText: String)
    func fetchSearchedGroups(text: String)
}

/// Service with requests to VK API.
final class VKNetworkService: NetworkService, VKNetworkServiceProtocol {
    // MARK: - Private Constants.

    private enum Constants {
        static let ownerIDText = "owner_id"
        static let qText = "q"
        static let friendsGetText = "friends.get"
        static let photosGetAllText = "photos.getAll"
        static let groupsGetText = "groups.get"
        static let groupsSearchText = "groups.search"
    }

    // MARK: - Public methods.

    func fetchFriends(userIDText: String) {
        let queryItem = URLQueryItem(name: userIDText, value: String(Session.shared.userID))
        loadData(
            methodType: Constants.friendsGetText,
            queryItem: queryItem
        )
    }

    func fetchPhotoUser(ownerID: Int) {
        let queryItem = URLQueryItem(name: Constants.ownerIDText, value: String(ownerID))
        loadData(
            methodType: Constants.photosGetAllText,
            queryItem: queryItem
        )
    }

    func fetchUsersGroups(userIDText: String) {
        let queryItem = URLQueryItem(name: userIDText, value: String(Session.shared.userID))
        loadData(
            methodType: Constants.groupsGetText,
            queryItem: queryItem
        )
    }

    func fetchSearchedGroups(text: String) {
        let queryItem = URLQueryItem(name: Constants.qText, value: text)
        loadData(
            methodType: Constants.groupsSearchText,
            queryItem: queryItem
        )
    }
}
