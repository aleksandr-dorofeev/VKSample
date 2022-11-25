// MyGroupTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Screen with list of subscribed groups.
final class MyGroupTableViewCell: UITableViewCell {
    // MARK: - Private @IBOutlet.

    @IBOutlet private var groupImageView: UIImageView!
    @IBOutlet private var groupTitleLabel: UILabel!

    // MARK: - Public methods.

    func configure(with group: ItemGroup) {
        guard let groupAvatarText = group.avatar else { return }
        setImage(userPhotoURLText: groupAvatarText)
        groupTitleLabel.text = group.name
    }

    // MARK: - Private methods.

    private func setImage(userPhotoURLText: String) {
        let url = URL(string: userPhotoURLText)
        DispatchQueue.global().async {
            guard let url = url else { return }
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                guard let data = data else { return }
                self.groupImageView.image = UIImage(data: data)
            }
        }
    }
}
