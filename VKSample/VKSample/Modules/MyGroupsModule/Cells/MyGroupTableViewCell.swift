// MyGroupTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Screen with list of subscribed groups.
final class MyGroupTableViewCell: UITableViewCell {
    // MARK: - Private @IBOutlet.

    @IBOutlet private var groupImageView: UIImageView!
    @IBOutlet private var groupTitleLabel: UILabel!

    // MARK: - Public methods.

    func configure(with group: Group, service: ImageService) {
        guard let avatarUrl = group.avatar else { return }
        groupImageView.image = service.getPhoto(url: avatarUrl)
        groupTitleLabel.text = group.name
    }
}
