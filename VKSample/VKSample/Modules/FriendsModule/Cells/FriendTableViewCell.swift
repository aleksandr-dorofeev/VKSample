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

    func configure(with friend: ItemFriend) {
        guard let avatar = friend.avatar else { return }
        setImage(avatarURLText: avatar)
        nameLabel.text = "\(friend.firstName) \(friend.lastName)"
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        friendImageView.image = UIImage(named: Constants.userPlaceholderString)
    }

    // MARK: - Private methods.

    private func setImage(avatarURLText: String) {
        let url = URL(string: avatarURLText)
        DispatchQueue.global().async {
            guard let url = url else { return }
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                guard let data = data else { return }
                self.friendImageView.image = UIImage(data: data)
            }
        }
    }
}
