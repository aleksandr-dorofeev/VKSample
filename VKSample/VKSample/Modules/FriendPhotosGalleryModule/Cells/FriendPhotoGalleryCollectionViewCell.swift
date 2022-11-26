// FriendPhotoGalleryCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Cell with friend's photo.
final class FriendPhotoGalleryCollectionViewCell: UICollectionViewCell {
    // MARK: - Private Constants.

    private enum Constants {
        static let imagePlaceholderString = "imagePlaceholder"
    }

    // MARK: - Private @IBOutlet.

    @IBOutlet private var friendPhotoImageView: UIImageView!
    @IBOutlet private var backgroundPhotoView: UIView!

    // MARK: - Public methods.

    func configure(imageUrlString: String) {
        backgroundPhotoView.layer.borderWidth = 2
        backgroundPhotoView.layer.borderColor = UIColor.black.cgColor
        ImageLoader.shared.setImage(userPhotoURLText: imageUrlString, imageView: friendPhotoImageView)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        friendPhotoImageView.image = UIImage(named: Constants.imagePlaceholderString)
    }
}
