// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire

/// Base network service with load data method.
class NetworkService {
    // MARK: - Public enums.

    enum RequestMethod: CustomStringConvertible {
        case getGroups
        case getFriends
        case searchGroups(queryText: String)
        case getPhotos(ownerID: Int)
        case newsFeed

        var description: String {
            switch self {
            case .getFriends:
                return Constants.friendsGetText
            case .getGroups:
                return Constants.groupsGetText
            case .searchGroups:
                return Constants.groupsSearchText
            case .getPhotos:
                return Constants.photosGetAllText
            case .newsFeed:
                return Constants.newsGetText
            }
        }

        var parametersMap: Parameters {
            switch self {
            case .getFriends:
                return [Constants.fieldsParamText: Constants.friendFieldsValue]
            case .getGroups:
                return [Constants.extendedParamText: Constants.extendedParamValue]
            case let .searchGroups(query):
                return [Constants.queryParamText: query]
            case let .getPhotos(userID):
                return [
                    Constants.extendedParamText: Constants.extendedParamValue,
                    Constants.ownerIDParamText: userID
                ]
            case .newsFeed:
                return [Constants.filtersText: Constants.postTypeText]
            }
        }
    }

    // MARK: - Private Constants.

    private enum Constants {
        static let friendsGetText = "friends.get"
        static let photosGetAllText = "photos.getAll"
        static let groupsGetText = "groups.get"
        static let groupsSearchText = "groups.search"
        static let newsGetText = "newsfeed.get"
        static let baseURLText = "https://api.vk.com/method/"
        static let fieldsParamText = "fields"
        static let friendFieldsValue = "nickname, photo_100"
        static let extendedParamText = "extended"
        static let filtersText = "filters"
        static let extendedParamValue = "1"
        static let queryParamText = "q"
        static let ownerIDParamText = "owner_id"
        static let accessTokenParamText = "access_token"
        static let versionParamText = "v"
        static let versionParamValue = "5.131"
        static let postTypeText = "post"
        static let photoTypeText = "wall_photo"
    }

    // MARK: - Private properties.

    private let baseQueryParameters: Parameters = [
        Constants.accessTokenParamText: Session.shared.token,
        Constants.versionParamText: Constants.versionParamValue
    ]

    // MARK: - Public methods.

    func loadData<T: Decodable>(methodType: RequestMethod, completion: @escaping (Result<[T], Error>) -> Void) {
        let url = "\(Constants.baseURLText)\(methodType.description)"
        let methodParams = methodType.parametersMap
        let parameters = baseQueryParameters.merging(methodParams) { _, _ in }
        AF.request(url, parameters: parameters).responseData { response in
            guard let data = response.data else { return }
            do {
                let object = try JSONDecoder().decode(VKResponse<T>.self, from: data)
                completion(.success(object.items))
            } catch {
                completion(.failure(error))
            }
        }
    }

    func loadNews(methodType: RequestMethod, completion: @escaping (Result<VKNewsResponse, Error>) -> Void) {
        let url = "\(Constants.baseURLText)\(methodType.description)"
        let methodParams = methodType.parametersMap
        let parameters = baseQueryParameters.merging(methodParams) { _, _ in }
        AF.request(url, parameters: parameters).responseData { response in
            guard let data = response.data else { return }
            do {
                let object = try JSONDecoder().decode(VKNewsResponse.self, from: data)
                completion(.success(object))
            } catch {
                completion(.failure(error))
                print(error)
            }
        }
    }
}
