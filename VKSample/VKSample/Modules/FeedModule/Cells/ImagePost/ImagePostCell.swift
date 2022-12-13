// ImagePostCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Cell with image.
final class ImagePostCell: UITableViewCell, PostConfigurable {
    // MARK: - Private Constants.

    private enum Constants {
        static let placeholderImageName = "imagePlaceholder"
    }

    // MARK: - Private @IBOutlets.

    @IBOutlet private var postImageView: UIImageView!

    // MARK: - Public methods.

    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView.image = UIImage(named: Constants.placeholderImageName)
    }

    func configure(news: News) {
        guard let imageName = news.attachments?.first?.photo?.url else { return }
        ImageLoader.shared.setImage(userPhotoURLText: imageName, imageView: postImageView)
    }
}
