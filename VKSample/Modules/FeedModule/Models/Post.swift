// Post.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Post model.
struct Post {
    let profileName: String
    let profileImageName: String
    let publicationDate: String
    let postText: String
    let imageNames: [String]
    let amountOfLikes: Int
    let amountOfMessages: Int
    let amountOfViews: Int
}

/// Mock of posts.
struct Posts {
    static func getPosts() -> [Post] {
        [
            Post(
                profileName: "Валерий Меладзе",
                profileImageName: "Meladze",
                publicationDate: "Вчера в 17:34",
                postText: "Прощай цыганка Сэра, были твои губы сладкие как вино...",
                imageNames: ["Meladze1", "Meladze2", "Meladze3", "Meladze4"],
                amountOfLikes: 15,
                amountOfMessages: 23,
                amountOfViews: 104
            ),
            Post(
                profileName: "Филипп Киркоров",
                profileImageName: "Kirkorov",
                publicationDate: "Вчера в 20:36",
                postText: "Гыыыыыыыыыыыыыыыы",
                imageNames: ["Fil1", "Fil2"],
                amountOfLikes: 56,
                amountOfMessages: 15,
                amountOfViews: 34
            ),
            Post(
                profileName: "Валерий Леонтьев",
                profileImageName: "Leontev",
                publicationDate: "Позавчера в 13:15",
                postText: "Продаю свои наряды по привлекательной цене, все детали в лс",
                imageNames: ["Leontev1", "Leontev2", "Leontev3"],
                amountOfLikes: 78,
                amountOfMessages: 148,
                amountOfViews: 205
            ),
            Post(
                profileName: "Михаил Круг",
                profileImageName: "Krug",
                publicationDate: "В среду в 21:00",
                postText: "А для вас я никто",
                imageNames: ["Krug1"],
                amountOfLikes: 23,
                amountOfMessages: 1,
                amountOfViews: 50
            )
        ]
    }
}
