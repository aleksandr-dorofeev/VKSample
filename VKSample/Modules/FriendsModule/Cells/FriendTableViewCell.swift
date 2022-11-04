// FriendTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// User-friend cell.
final class FriendTableViewCell: UITableViewCell {
    // MARK: - Private @IBOutlet.

    @IBOutlet private var friendImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!

    // MARK: - Public methods

    func configure(with friend: Friend) {
        friendImageView.image = UIImage(named: friend.avatarImageName)
        nameLabel.text = friend.name
    }
}
