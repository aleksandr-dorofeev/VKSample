// GroupTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Cell with  unsubscribes groups.
final class GroupTableViewCell: UITableViewCell {
    // MARK: - Private Constants.

    private enum Constants {
        static let subscribeButtonTitle = "Вступить"
        static let unSubscribeButtonTitle = "Выйти"
    }

    private enum Colors {
        static let greenColor = "Green"
        static let blueColor = "Blue"
    }

    // MARK: - Private @IBOutlet.

    @IBOutlet private var groupImageView: UIImageView!
    @IBOutlet private var groupTitleLabel: UILabel!
    @IBOutlet private var subscribeButton: UIButton!

    // MARK: - Life cycle.

    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    // MARK: - Public methods.

    func configure(with group: ItemGroup) {
        guard let groupAvatarText = group.avatar else { return }
        groupImageView.image = UIImage(named: groupAvatarText)
        groupTitleLabel.text = group.name
    }

    // MARK: - Private methods.

    private func configureUI() {
        configureSubscribeButton()
    }

    private func configureSubscribeButton() {
        subscribeButton.layer.cornerRadius = 7
        subscribeButton.layer.borderColor = UIColor.gray.cgColor
        subscribeButton.layer.borderWidth = 2
    }
}
