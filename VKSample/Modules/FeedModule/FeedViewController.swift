// FeedViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Screen with feed.
final class FeedViewController: UIViewController {
    // MARK: - Private Constants.

    private enum Constants {
        static let postCellName = "PostTableViewCell"
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
            UINib(nibName: Constants.postCellName, bundle: nil),
            forCellReuseIdentifier: Constants.postCellID
        )
    }

    private func hightCellForImageCollection(numberRow: Int) -> CGFloat {
        guard numberRow < posts.count else { return 0 }
        switch posts[numberRow].imageNames.count {
        case 1:
            return view.bounds.width / 2
        case let count where count > 1:
            return (view.bounds.width / 2) * CGFloat(lroundf(Float(posts[numberRow].imageNames.count) / 2))
        default:
            return 0
        }
    }
}

/// UITableViewDataSource.
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
        cell.configure(post: post, viewHight: hightCellForImageCollection(numberRow: indexPath.row))
        return cell
    }
}
