// Friend.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Variants with marital statuses.
enum MaritalStatus: String {
    case activelyLooking = "Actively Looking"
    case single = "Single"
    case married = "Married"
    case isComplicated = "Is Complicated"
    case none = "Unknown"
}

/// User model.
struct Friend {
    let name: String
    let avatarImageName: String
    let description: String?
    let maritalStatus: MaritalStatus
    let profileImageNames: [String]?
}

/// Amount of users.
struct Friends {
    static func getFriends() -> [Friend] {
        [
            Friend(
                name: "Валерий Меладзе",
                avatarImageName: "Meladze",
                description: "Гыыыыыыыыыыыы",
                maritalStatus: MaritalStatus.married,
                profileImageNames: ["Meladze1", "Meladze2", "Meladze3", "Meladze4"]
            ),
            Friend(
                name: "Леонид Агутин",
                avatarImageName: "Agutin",
                description: "Ээээээээээээээээ",
                maritalStatus: MaritalStatus.married,
                profileImageNames: nil
            ),
            Friend(
                name: "Филип Киркоров",
                avatarImageName: "Kirkorov",
                description: "Уууууууууууууууууууу",
                maritalStatus: MaritalStatus.isComplicated,
                profileImageNames: ["Fil1", "Fil2"]
            ),
            Friend(
                name: "Елена Ваенга",
                avatarImageName: "Vaenga",
                description: "Уххххххххххх",
                maritalStatus: MaritalStatus.isComplicated,
                profileImageNames: ["Vaenga1"]
            ),
            Friend(
                name: "Михаил Круг",
                avatarImageName: "Krug",
                description: "Вечер в хатку",
                maritalStatus: MaritalStatus.married,
                profileImageNames: ["Krug1"]
            ),
            Friend(
                name: "Лолита",
                avatarImageName: "Lolita",
                description: nil,
                maritalStatus: MaritalStatus.isComplicated,
                profileImageNames: nil
            ),
            Friend(
                name: "Стас Пьеха",
                avatarImageName: "Peha",
                description: "Всем привет, добавляйтесь в друзья",
                maritalStatus: MaritalStatus.none,
                profileImageNames: nil
            ),
            Friend(
                name: "София Ротару",
                avatarImageName: "Rotaru",
                description: "Пою песни",
                maritalStatus: MaritalStatus.single,
                profileImageNames: nil
            ),
            Friend(
                name: "Стас Костюшкин",
                avatarImageName: "Stas",
                description: "Я не гей",
                maritalStatus: MaritalStatus.isComplicated,
                profileImageNames: nil
            ),
            Friend(
                name: "Моргенштерн",
                avatarImageName: "Morgenshtern",
                description: "Я такой крутой, ваще",
                maritalStatus: MaritalStatus.activelyLooking,
                profileImageNames: ["Morg1", "Morg2"]
            ),
            Friend(
                name: "Валерий Леонтьев",
                avatarImageName: "Leontev",
                description: "Продаю наряды",
                maritalStatus: MaritalStatus.activelyLooking,
                profileImageNames: ["Leontev1", "Leontev2", "Leontev3"]
            ),
            Friend(
                name: "Ева Польна",
                avatarImageName: "Polna",
                description: nil,
                maritalStatus: MaritalStatus.married,
                profileImageNames: ["Polna1", "Polna2"]
            ),
            Friend(
                name: "Катя Лель",
                avatarImageName: "Lel",
                description: "Гадаю на картах",
                maritalStatus: MaritalStatus.none,
                profileImageNames: nil
            )
        ]
    }
}
