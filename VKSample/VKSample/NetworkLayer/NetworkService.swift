// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation

/// Network interface for VK API.
protocol NetworkServiceProtocol {
    func getFriends(userIDText: String)
    func getPhotoUser(ownerID: Int)
    func getGroupUser(userIDText: String)
    func getSearchedGroup(text: String)
}

/// Network layer for VK API.
final class NetworkService: NetworkServiceProvider {
    // MARK: - Private Constants.

    private enum Constants {
        static let baseURL = "https://api.vk.com"
        static let methodPathText = "/method/"
        static let fieldsParamText = "fields"
        static let accessTokenParamText = "access_token"
        static let versionParamText = "v"
        static let versionText = "5.131"
        static let birthdayDateText = "bdate"
        static let ownerIDText = "owner_id"
        static let qText = "q"
        static let friendsGetText = "friends.get"
        static let photosGetAllText = "photos.getAll"
        static let groupsGetText = "groups.get"
        static let groupsSearchText = "groups.search"
    }

    // MARK: - Public methods.

    func getFriends(userIDText: String) {
        loadData(
            method: Constants.friendsGetText,
            parameterMap: [userIDText: String(Session.shared.userID)]
        )
    }

    func getPhotoUser(ownerID: Int) {
        loadData(
            method: Constants.photosGetAllText,
            parameterMap: [Constants.ownerIDText: String(ownerID)]
        )
    }

    func getGroupUser(userIDText: String) {
        loadData(
            method: Constants.groupsGetText,
            parameterMap: [userIDText: String(Session.shared.userID)]
        )
    }

    func getSearchedGroup(text: String) {
        loadData(
            method: Constants.groupsSearchText,
            parameterMap: [Constants.qText: text]
        )
    }

    // MARK: - Private methods.

    private func loadData(method: String, parameterMap: [String: String]) {
        let path = Constants.methodPathText + method
        var parameters: Parameters = [
            Constants.fieldsParamText: Constants.birthdayDateText,
            Constants.accessTokenParamText: Session.shared.token,
            Constants.versionParamText: Constants.versionText
        ]
        for parameter in parameterMap {
            parameters[parameter.key] = parameter.value
        }
        let url = Constants.baseURL + path
        AF.request(
            url,
            method: .get,
            parameters: parameters
        ).responseJSON { response in
            guard let value = response.value else { return }
            print(value)
            print(url)
            print(parameters)
        }
    }
}
