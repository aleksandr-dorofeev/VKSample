// PostFooterCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Footer for post.
final class PostFooterCell: UITableViewCell, PostConfigurable {
    // MARK: - Private @IBOutlets.

    @IBOutlet private var likeControlView: LikeControlView!
    @IBOutlet private var amountMessagesLabel: UILabel!
    @IBOutlet private var amountViewsLabel: UILabel!
    @IBOutlet var amountRepostsLabel: UILabel!

    // MARK: - Public methods.

    func configure(news: News) {
        guard
            let amountLikes = news.likes?.count,
            let amountMessages = news.comments?.count,
            let amountViews = news.views?.count,
            let amountReposts = news.reposts?.count
        else { return }
        likeControlView.amountLikes = amountLikes
        amountMessagesLabel.text = "\(amountMessages)"
        amountViewsLabel.text = "\(amountViews)"
        amountRepostsLabel.text = "\(amountReposts)"
    }
}
