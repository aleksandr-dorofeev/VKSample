// TextPostCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Cell with text.
final class TextPostCell: UITableViewCell, PostConfigurable {
    // MARK: - Private @IBOutlets.

    @IBOutlet private var postTextView: UITextView!

    // MARK: - Public methods.

    func configure(post: News) {
        postTextView.text = post.text
    }
}
