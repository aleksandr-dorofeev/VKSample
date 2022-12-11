// FriendPhotoGalleryCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Cell with friend's photo.
final class FriendPhotoGalleryCollectionViewCell: UICollectionViewCell {
    // MARK: - Private @IBOutlet.

    @IBOutlet private var friendPhotoImageView: UIImageView!
    @IBOutlet private var backgroundPhotoView: UIView!

    // MARK: - Public methods.

    func configure(image: UIImage) {
        backgroundPhotoView.layer.borderWidth = 2
        backgroundPhotoView.layer.borderColor = UIColor.black.cgColor
        friendPhotoImageView.image = image
    }
}
