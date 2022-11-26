// MyGroupTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Screen with list of subscribed groups.
final class MyGroupTableViewCell: UITableViewCell {
    // MARK: - Private @IBOutlet.

    @IBOutlet private var groupImageView: UIImageView!
    @IBOutlet private var groupTitleLabel: UILabel!

    // MARK: - Public methods.

    func configure(with group: Group) {
        guard let groupAvatarText = group.avatar else { return }
        ImageLoader.shared.setImage(userPhotoURLText: groupAvatarText, imageView: groupImageView)
        groupTitleLabel.text = group.name
    }
}
