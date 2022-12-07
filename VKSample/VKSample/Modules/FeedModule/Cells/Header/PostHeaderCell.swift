// PostHeaderCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Header for post.
final class PostHeaderCell: UITableViewCell, PostConfigurable {
    // MARK: - Private Constants.

    private enum Constants {
        static let viewColorName = "ViewColor"
    }

    // MARK: - Private @IBOutlets.

    @IBOutlet private var backgroundCustomView: UIView!
    @IBOutlet private var profileNameLabel: UILabel!
    @IBOutlet private var postingTimeLabel: UILabel!
    @IBOutlet private var profileImageView: UIImageView! {
        didSet {
            profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        }
    }

    // MARK: - Life cycle.

    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    // MARK: - Public methods.

    func configure(news: News) {
        guard let avatar = news.avatarPath else { return }
        profileNameLabel.text = news.authorName
        postingTimeLabel.text = DateFormatter.convertDate(dateValue: news.date)
        ImageLoader.shared.setImage(userPhotoURLText: avatar, imageView: profileImageView)
    }

    // MARK: - Private methods.

    private func configureUI() {
        configureBackgroundView()
    }

    private func configureBackgroundView() {
        backgroundCustomView.layer.cornerRadius = backgroundCustomView.frame.width / 2
        backgroundCustomView.backgroundColor = UIColor(named: Constants.viewColorName)
    }
}
