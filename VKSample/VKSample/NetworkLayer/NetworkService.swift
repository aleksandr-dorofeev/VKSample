// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation

/// Base network service with load data method.
class NetworkService {
    // MARK: - Private Constants.

    private enum Constants {
        static let baseURLString = "https://api.vk.com/"
        static let methodPathText = "method/"
        static let fieldsParamText = "fields"
        static let accessTokenParamText = "access_token"
        static let versionParamText = "v"
        static let versionText = "5.131"
        static let birthdayDateText = "bdate"
    }

    // MARK: - Public method.

    func loadData(methodType: String, queryItem: URLQueryItem) {
        guard let value = queryItem.value else { return }
        let path = Constants.methodPathText + methodType
        let parameters: Parameters = [
            Constants.fieldsParamText: Constants.birthdayDateText,
            Constants.accessTokenParamText: Session.shared.token,
            queryItem.name: value,
            Constants.versionParamText: Constants.versionText
        ]
        let url = Constants.baseURLString + path
        AF.request(
            url,
            parameters: parameters
        ).responseJSON { response in
            guard let value = response.value else { return }
            print(value)
            print(url)
        }
    }
}
