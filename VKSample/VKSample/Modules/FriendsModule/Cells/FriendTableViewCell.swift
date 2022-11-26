// FriendTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// User-friend cell.
final class FriendTableViewCell: UITableViewCell {
    // MARK: - Private Constants.

    private enum Constants {
        static let userPlaceholderString = "userPlaceholder"
    }

    // MARK: - Private @IBOutlet.

    @IBOutlet private var friendImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!

    // MARK: - Public methods.

    override func prepareForReuse() {
        super.prepareForReuse()
        friendImageView.image = UIImage(named: Constants.userPlaceholderString)
    }

    func configure(with friend: Friend) {
        guard let avatar = friend.avatar else { return }
        ImageLoader.shared.setImage(userPhotoURLText: avatar, imageView: friendImageView)
        nameLabel.text = "\(friend.firstName) \(friend.lastName)"
    }
}
