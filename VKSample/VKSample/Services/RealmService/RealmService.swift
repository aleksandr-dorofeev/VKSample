// RealmService.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Methods for realm.
final class RealmService {
    // MARK: - Private Properties.

    private static let deleteIfMigration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)

    // MARK: - Public methods.

    static func writeData<T: Object>(items: [T]) {
        do {
            let realm = try Realm(configuration: deleteIfMigration)
            try realm.write {
                realm.add(items, update: .modified)
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    static func readData<T: Object>(
        _ type: T.Type,
        config: Realm.Configuration = Realm.Configuration.defaultConfiguration
    ) -> Results<T>? {
        do {
            let realm = try Realm(configuration: deleteIfMigration)
            return realm.objects(type)
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }

    static func deleteGroup<T: Object>(_ group: T) {
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
