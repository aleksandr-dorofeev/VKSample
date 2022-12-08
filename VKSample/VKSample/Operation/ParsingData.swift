// ParsingData.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Parse data.
final class ParsingData: Operation {
    // MARK: - Public properties.

    var outputData: [Group] = []

    // MARK: - Pubic methods.

    override func main() {
        guard let getDataOperation = dependencies.first as? GetDataOperation,
              let data = getDataOperation.data else { return }
        do {
            let response = try JSONDecoder().decode(VKResponse<Group>.self, from: data)
            outputData = response.items
        } catch {
            print(error.localizedDescription)
        }
    }
}
