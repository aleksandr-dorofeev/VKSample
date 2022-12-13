// VKNetworkServiceProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Network interface for VK API.
protocol VKNetworkServiceProtocol {
    func fetchFriends(completion: @escaping (Result<[Friend], Error>) -> Void)
    func fetchUsersPhoto(ownerID: Int, completion: @escaping (Result<[Photo], Error>) -> Void)
    func fetchUsersGroups(completion: @escaping (Result<[Group], Error>) -> Void)
    func fetchSearchedGroups(text: String, completion: @escaping (Result<[Group], Error>) -> Void)
    func fetchNewsfeed(
        startTime: Int?,
        page: String?,
        completion: @escaping (Result<VKNewsResponse, Error>) -> Void
    )
    func fetchOperationGroups()
}
