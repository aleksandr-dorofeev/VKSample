// PostImageCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Cell with post image.
final class PostImageCollectionViewCell: UICollectionViewCell {
    // MARK: - Private @IBOutlet.

    @IBOutlet private var postImageView: UIImageView!

    // MARK: - Public methods.

    func configure(postImageName: String) {
        postImageView.image = UIImage(named: postImageName)
    }
}
