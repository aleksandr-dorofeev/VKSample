// PromiseService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation
import PromiseKit

/// Promise request service.
final class PromiseService {
    // MARK: - Private properties.

    private let networkService = NetworkService()

    // MARK: - Public methods.

    func friendsRequest() -> Promise<VKResponse<Friend>> {
        let promise = Promise<VKResponse<Friend>> { resolver in
            let url = networkService.configurePromiseFriendsUrl()
            let params = networkService.configurePromiseFriendsParams()
            AF.request(url, parameters: params).responseData { response in
                guard let response = response.data else { return }
                do {
                    let object = try JSONDecoder().decode(VKResponse<Friend>.self, from: response)
                    resolver.fulfill(object)
                } catch {
                    resolver.reject(error)
                }
            }
        }
        return promise
    }
}
