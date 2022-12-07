// ImagePostCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Cell with image.
final class ImagePostCell: UITableViewCell, PostConfigurable {
    // MARK: - Private @IBOutlets.

    @IBOutlet private var postImageView: UIImageView!

    // MARK: - Public methods.

    func configure(news: News) {
        guard let imageName = news.avatarPath else { return }
        ImageLoader.shared.setImage(userPhotoURLText: imageName, imageView: postImageView)
    }
}
