// FriendTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// User-friend cell.
final class FriendTableViewCell: UITableViewCell {
    // MARK: - Private @IBOutlet.

    @IBOutlet private var friendImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!

    // MARK: - Public methods.

    func configure(service: ImageService, with friend: Friend) {
        guard let avatarUrl = friend.avatar else { return }
        friendImageView.image = service.getPhoto(url: avatarUrl)
        nameLabel.text = "\(friend.firstName) \(friend.lastName)"
    }
}
