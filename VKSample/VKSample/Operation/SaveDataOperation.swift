// SaveDataOperation.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Save data to realm.
final class SaveDataOperation: AsyncOperation {
    // MARK: - Public methods.

    override func main() {
        guard let parseData = dependencies.first as? ParsingData else { return }
        RealmService.writeData(items: parseData.outputData)
    }
}
