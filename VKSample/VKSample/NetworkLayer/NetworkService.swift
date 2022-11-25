// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation
import RealmSwift

/// Base network service with load and save data methods.
class NetworkService {
    // MARK: - Public enums.

    enum RequestMethod: CustomStringConvertible {
        case getGroups
        case getFriends
        case searchGroups(queryText: String)
        case getPhotos(ownerID: Int)

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
            }
        }
    }

    // MARK: - Private Constants.

    private enum Constants {
        static let friendsGetText = "friends.get"
        static let photosGetAllText = "photos.getAll"
        static let groupsGetText = "groups.get"
        static let groupsSearchText = "groups.search"
        static let baseURLText = "https://api.vk.com/method/"
        static let fieldsParamText = "fields"
        static let friendFieldsValue = "nickname, photo_100"
        static let extendedParamText = "extended"
        static let extendedParamValue = "1"
        static let queryParamText = "q"
        static let ownerIDParamText = "owner_id"
        static let accessTokenParamText = "access_token"
        static let versionParamText = "v"
        static let versionParamValue = "5.131"
        static let photoText = "photo_100"
    }

    // MARK: - Private properties.

    private let baseQueryParameters: Parameters = [
        Constants.accessTokenParamText: Session.shared.token,
        Constants.versionParamText: Constants.versionParamValue
    ]
    private let decoder = JSONDecoder()

    // MARK: - Public methods.

    func loadData<T: Decodable>(methodType: RequestMethod, completion: @escaping (Result<T, Error>) -> Void) {
        let url = "\(Constants.baseURLText)\(methodType.description)"
        let methodParams = methodType.parametersMap
        let parameters = baseQueryParameters.merging(methodParams) { _, _ in }
        AF.request(url, parameters: parameters).responseData { [weak self] response in
            guard
                let self = self,
                let data = response.value else { return }
            if let error = response.error {
                completion(.failure(error))
            }
            guard let result = try? self.decoder.decode(T.self, from: data) else { return }
            completion(.success(result))
        }
    }

    func saveData<T: Object>(items: [T]) where T: Decodable {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(items)
            }
        } catch {
            print(error)
        }
    }
}
