// TextPostCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Cell with text.
final class TextPostCell: UITableViewCell, PostConfigurable {
    // MARK: - Private @IBOutlets.

    @IBOutlet var postTextLabel: UILabel!

    // MARK: - Public methods.

    func configure(news: News) {
        postTextLabel.text = news.text
    }
}
