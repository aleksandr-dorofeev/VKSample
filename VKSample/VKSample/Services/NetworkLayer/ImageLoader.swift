// ImageLoader.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class ImageLoader {
    static let shared = ImageLoader()
    private init() {}
    func setImage(userPhotoURLText: String, imageView: UIImageView) {
        let url = URL(string: userPhotoURLText)
        guard let url = url else { return }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            DispatchQueue.main.async {
                guard let data = data,
                      let image = UIImage(data: data) else { return }
                imageView.image = image
            }
        }.resume()
    }
}
