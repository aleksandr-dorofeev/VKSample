// VKNetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Service with requests to VK API.
final class VKNetworkService: VKNetworkServiceProtocol {
    // MARK: - Private Properties.

    private let networkService = NetworkService()

    // MARK: - Public methods.

    func fetchFriends(completion: @escaping (Result<[Friend], Error>) -> Void) {
        networkService.loadData(methodType: .getFriends, completion: completion)
    }

    func fetchUsersPhoto(ownerID: Int, completion: @escaping (Result<[Photo], Error>) -> Void) {
        networkService.loadData(methodType: .getPhotos(ownerID: ownerID), completion: completion)
    }

    func fetchUsersGroups(completion: @escaping (Result<[Group], Error>) -> Void) {
        networkService.loadData(methodType: .getGroups, completion: completion)
    }

    func fetchSearchedGroups(text: String, completion: @escaping (Result<[Group], Error>) -> Void) {
        networkService.loadData(methodType: .searchGroups(queryText: text), completion: completion)
    }

    func fetchNewsfeed(
        startTime: Int? = nil,
        page: String? = nil,
        completion: @escaping (Result<VKNewsResponse, Error>) -> Void
    ) {
        networkService.loadNews(methodType: .newsFeed(time: startTime, nextPage: page), completion: completion)
    }

    func fetchOperationGroups() {
        networkService.fetchOperationGroups(methodType: .getGroups)
    }
}
