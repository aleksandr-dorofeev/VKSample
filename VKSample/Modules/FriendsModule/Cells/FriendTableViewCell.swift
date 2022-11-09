// FriendTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// User-friend cell.
final class FriendTableViewCell: UITableViewCell {
    // MARK: Private Constants.

    private enum Constants {
        static let transformKeyPathText = "transform.scale"
    }

    // MARK: - Private @IBOutlet.

    @IBOutlet private var friendImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var shadowAvatarView: ShadowAvatarView!

    // MARK: - Life cycle.

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    // MARK: - Public methods

    func configure(with friend: Friend) {
        friendImageView.image = UIImage(named: friend.avatarImageName)
        nameLabel.text = "\(friend.name.firstName) \(friend.name.lastName ?? "")"
    }

    // MARK: - Private methods.

    private func setupUI() {
        tapGesture()
    }

    private func tapGesture() {
        shadowAvatarView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(avatarAnimationAction))
        shadowAvatarView.addGestureRecognizer(tapGesture)
    }

    @objc private func avatarAnimationAction() {
        let animation = CASpringAnimation(keyPath: Constants.transformKeyPathText)
        animation.fromValue = 0.1
        animation.toValue = 1
        animation.stiffness = 50
        animation.mass = 2
        animation.duration = 4
        animation.fillMode = .forwards
        shadowAvatarView.layer.add(animation, forKey: nil)
    }
}
