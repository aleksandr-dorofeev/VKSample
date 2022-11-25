// RealmDataBase.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Class with methods for realm.
final class RealmDataBase {
    func saveData<T: Decodable>(items: [T]) where T: Object {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(items)
            }
            print("Realm: \(realm)")
        } catch {
            print(error)
        }
    }
}
