// VKNetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Service with requests to VK API.
final class VKNetworkService: NetworkService, VKNetworkServiceProtocol {
    // MARK: - Public methods.

    func fetchFriends(completion: @escaping (Result<[Friend], Error>) -> Void) {
        loadData(methodType: .getFriends, completion: completion)
    }

    func fetchUsersPhoto(ownerID: Int, completion: @escaping (Result<[Photo], Error>) -> Void) {
        loadData(methodType: .getPhotos(ownerID: ownerID), completion: completion)
    }

    func fetchUsersGroups(completion: @escaping (Result<[Group], Error>) -> Void) {
        loadData(methodType: .getGroups, completion: completion)
    }

    func fetchSearchedGroups(text: String, completion: @escaping (Result<[Group], Error>) -> Void) {
        loadData(methodType: .searchGroups(queryText: text), completion: completion)
    }

    func fetchNewsfeed(completion: @escaping (Result<VKNewsResponse, Error>) -> Void) {
        loadNews(methodType: .newsFeed, completion: completion)
    }
}
