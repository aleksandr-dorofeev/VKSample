// ParsingGroupsData.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Parse groups data.
final class ParsingGroupsData: Operation {
    // MARK: - Public properties.

    var groups: [Group] = []

    // MARK: - Pubic methods.

    override func main() {
        guard let getDataOperation = dependencies.first as? GetGroupsDataOperation,
              let data = getDataOperation.data else { return }
        do {
            let response = try JSONDecoder().decode(VKResponse<Group>.self, from: data)
            groups = response.items
        } catch {
            print(error.localizedDescription)
        }
    }
}
