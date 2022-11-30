// RealmService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Class with methods for realm.
final class RealmService {
    // MARK: - Public properties.

    private var friendsToken: NotificationToken?
    private var groupsToken: NotificationToken?
    private var photosToken: NotificationToken?

    // MARK: - Public methods.

    func writeData<T: Object>(items: [T]) where T: Decodable {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(items, update: .modified)
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    @discardableResult func readData<T: Object>(items: T.Type) -> Results<T>? {
        var data: Results<T>?
        do {
            let realm = try Realm()
            data = realm.objects(T.self)
        } catch {
            print(error.localizedDescription)
        }
        return data
    }

    func deleteGroup<T: Object>(_ group: T) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(group)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
