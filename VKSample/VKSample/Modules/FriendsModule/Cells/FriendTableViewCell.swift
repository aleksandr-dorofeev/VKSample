// FriendTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// User-friend cell.
final class FriendTableViewCell: UITableViewCell {
    // MARK: - Private @IBOutlet.

    @IBOutlet private var friendImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!

    // MARK: - Public methods.

    func configure(image: UIImage, with friend: Friend) {
        friendImageView.image = image
        nameLabel.text = "\(friend.firstName) \(friend.lastName)"
    }
}
