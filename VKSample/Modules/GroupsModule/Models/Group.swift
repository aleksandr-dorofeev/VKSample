// Group.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Group.
struct Group: Equatable {
    let name: String
    let titleImageName: String
}

/// Mock of groups.
struct Groups {
    static func getGroups() -> [Group] {
        [
            Group(
                name: "Русский шансон",
                titleImageName: "Shanson"
            ),
            Group(
                name: "Европа плюс Радио",
                titleImageName: "EuropePlus"
            ),
            Group(
                name: "Золотой грамофон",
                titleImageName: "GoldGram"
            ),
            Group(
                name: "Супер попса",
                titleImageName: "PopHits"
            ),
            Group(
                name: "Фан-клуб Филиппа Киркорова❤️",
                titleImageName: "Fill"
            ),
            Group(
                name: "Открытки для WatsApp",
                titleImageName: "Cards"
            ),
            Group(
                name: "Катя Лель - будущее по картам Таро",
                titleImageName: "Taro"
            )
        ]
    }
}
