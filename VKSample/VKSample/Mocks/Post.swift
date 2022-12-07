// Post.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Type of posts.
enum PostType {
    case text
    case photo
}

/// Post.
struct Post {
    let profileName: String
    let profileImageName: String
    let publicationDate: String
    let postText: String?
    let imageName: String?
    let amountOfLikes: Int
    let amountOfMessages: Int
    let amountOfViews: Int
    let type: PostType
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
                imageName: "Meladze1",
                amountOfLikes: 15,
                amountOfMessages: 23,
                amountOfViews: 104,
                type: .photo
            ),
            Post(
                profileName: "Филипп Киркоров",
                profileImageName: "Kirkorov",
                publicationDate: "Вчера в 20:36",
                postText: "Гыыыыыыыыыыыыыыыы",
                imageName: "Fil1",
                amountOfLikes: 56,
                amountOfMessages: 15,
                amountOfViews: 34,
                type: .text
            ),
            Post(
                profileName: "Валерий Леонтьев",
                profileImageName: "Leontev",
                publicationDate: "Позавчера в 13:15",
                postText: "Продаю свои наряды по привлекательной цене, все детали в лс",
                imageName: "Leontev1",
                amountOfLikes: 78,
                amountOfMessages: 148,
                amountOfViews: 205,
                type: .photo
            ),
            Post(
                profileName: "Михаил Круг",
                profileImageName: "Krug",
                publicationDate: "В среду в 21:00",
                postText: "А для вас я никто",
                imageName: "Krug1",
                amountOfLikes: 23,
                amountOfMessages: 1,
                amountOfViews: 50,
                type: .text
            )
        ]
    }
}
