// SaveGroupsDataOperation.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Save groups data to realm.
final class SaveGroupsDataOperation: AsyncOperation {
    // MARK: - Public methods.

    override func main() {
        guard let parseData = dependencies.first as? ParsingGroupsData else { return }
        RealmService.writeData(items: parseData.outputData)
    }
}
