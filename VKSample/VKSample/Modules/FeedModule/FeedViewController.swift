// FeedViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Screen with feed.
final class FeedViewController: UIViewController {
    // MARK: - Private Constants.

    private enum Constants {
        static let postCellNibName = "PostTableViewCell"
        static let postCellID = "PostCell"
    }

    // MARK: - Private @IBOutlet.

    @IBOutlet private var feedTableView: UITableView!

    // MARK: - Private properties.

    private let posts = Posts.getPosts()

    // MARK: - Life cycle.

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - Private Methods

    private func configureUI() {
        configureTableView()
    }

    private func configureTableView() {
        feedTableView.rowHeight = UITableView.automaticDimension
        feedTableView.register(
            UINib(nibName: Constants.postCellNibName, bundle: nil),
            forCellReuseIdentifier: Constants.postCellID
        )
    }

    private func setupHightCellForPostImageCollectionView(numberRow: Int) -> CGFloat {
        let amountOfImages = posts[numberRow].imageNames.count
        let widthOfBounds = view.bounds.width
        switch amountOfImages {
        case 1:
            return widthOfBounds
        case let count where count > 1:
            return (widthOfBounds / 2) * CGFloat(lroundf(Float(amountOfImages) / 2))
        default:
            return 0
        }
    }
}

// MARK: - UITableViewDataSource.

extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.postCellID,
            for: indexPath
        ) as? PostTableViewCell,
            indexPath.row < posts.count
        else {
            return UITableViewCell()
        }
        let post = posts[indexPath.row]
        cell.configure(post: post, viewHight: setupHightCellForPostImageCollectionView(numberRow: indexPath.row))
        return cell
    }
}
