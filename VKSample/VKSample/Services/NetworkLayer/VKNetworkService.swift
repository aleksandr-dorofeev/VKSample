// VKNetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Network interface for VK API.
protocol VKNetworkServiceProtocol {
    func fetchFriends(completion: @escaping (Result<[Friend], Error>) -> Void)
    func fetchUsersPhoto(ownerID: Int, completion: @escaping (Result<[Photo], Error>) -> Void)
    func fetchUsersGroups(completion: @escaping (Result<[Group], Error>) -> Void)
    func fetchSearchedGroups(text: String, completion: @escaping (Result<[Group], Error>) -> Void)
}

/// Service with requests to VK API.
final class VKNetworkService: NetworkService, VKNetworkServiceProtocol {
    // MARK: - Public methods.

    func fetchFriends(completion: @escaping (Result<[Friend], Error>) -> Void) {
        loadData(
            methodType: .getFriends,
            completion: completion
        )
    }

    func fetchUsersPhoto(ownerID: Int, completion: @escaping (Result<[Photo], Error>) -> Void) {
        loadData(
            methodType: .getPhotos(ownerID: ownerID),
            completion: completion
        )
    }

    func fetchUsersGroups(completion: @escaping (Result<[Group], Error>) -> Void) {
        loadData(
            methodType: .getGroups,
            completion: completion
        )
    }

    func fetchSearchedGroups(text: String, completion: @escaping (Result<[Group], Error>) -> Void) {
        loadData(
            methodType: .searchGroups(queryText: text),
            completion: completion
        )
    }
}
