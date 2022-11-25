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

    func configure(imageURL: String) {
        backgroundPhotoView.layer.borderWidth = 2
        backgroundPhotoView.layer.borderColor = UIColor.black.cgColor
        setImage(userPhotoURLText: imageURL)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        friendPhotoImageView.image = UIImage(named: Constants.imagePlaceholderString)
    }

    // MARK: - Private methods.

    private func setImage(userPhotoURLText: String) {
        let url = URL(string: userPhotoURLText)
        DispatchQueue.global().async {
            guard let url = url else { return }
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                guard let data = data else { return }
                self.friendPhotoImageView.image = UIImage(data: data)
            }
        }
    }
}
