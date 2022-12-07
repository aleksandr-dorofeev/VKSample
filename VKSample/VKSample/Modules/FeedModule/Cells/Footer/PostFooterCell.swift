// PostFooterCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Footer for post.
final class PostFooterCell: UITableViewCell, PostConfigurable {
    // MARK: - Private @IBOutlets.

    @IBOutlet private var likeControlView: LikeControlView!
    @IBOutlet private var amountOfMessagesLabel: UILabel!
    @IBOutlet private var amountOfViewsLabel: UILabel!

    // MARK: - Public methods.

    func configure(post: News) {
//        amountOfViewsLabel.text = "\(post.amountOfViews)"
//        amountOfMessagesLabel.text = "\(news.amountOfMessages)"
//        likeControlView.amountLikes = news.amountOfLikes
    }
}
