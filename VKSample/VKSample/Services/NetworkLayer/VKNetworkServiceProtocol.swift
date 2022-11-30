// VKNetworkServiceProtocol.swift
// Copyright © RoadMap. All rights reserved.

/// Network interface for VK API.
protocol VKNetworkServiceProtocol {
    func fetchFriends(completion: @escaping (Result<[Friend], Error>) -> Void)
    func fetchUsersPhoto(ownerID: Int, completion: @escaping (Result<[Photo], Error>) -> Void)
    func fetchUsersGroups(completion: @escaping (Result<[Group], Error>) -> Void)
    func fetchSearchedGroups(text: String, completion: @escaping (Result<[Group], Error>) -> Void)
}
