// FeedViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

typealias PostCell = UITableViewCell & PostConfigurable

protocol PostConfigurable {
    func configure(news: News)
}

/// Screen with feed.
final class FeedViewController: UIViewController {
    // MARK: - Private Constants.

    private enum Constants {
        static let postHeaderNibName = "PostHeaderCell"
        static let postFooterNibName = "PostFooterCell"
        static let postTextNibName = "TextPostCell"
        static let postImageNibName = "ImagePostCell"
        static let errorTitleString = "Ошибка"
    }

    // MARK: - Private Types.

    private enum PostCellType: Int, CaseIterable {
        case header
        case content
        case footer
    }

    // MARK: - Private @IBOutlet.

    @IBOutlet private var feedTableView: UITableView!

    // MARK: - Private properties.

    private let vkNetworkService = VKNetworkService()
    private var news: [News] = []

    // MARK: - Life cycle.

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchNewsfeed()
    }

    // MARK: - Private Methods

    private func configureUI() {
        configureTableView()
    }

    private func fetchNewsfeed() {
        vkNetworkService.fetchNewsfeed(type: .all) { [weak self] items in
            guard let self = self else { return }
            switch items {
            case let .success(news):
                self.fetchFullNews(newsResponse: news)
            case let .failure(error):
                self.showErrorAlert(title: Constants.errorTitleString, message: "\(error.localizedDescription)")
            }
        }
    }

    private func fetchFullNews(newsResponse: VKNewsResponse) {
        newsResponse.news.forEach { result in
            if result.sourceID < 0 {
                guard let group = newsResponse.groups.filter({ group in
                    group.id == result.sourceID * -1
                }).first else { return }
                result.authorName = group.name
                result.avatarPath = group.avatar
            } else {
                guard let user = newsResponse.friends.filter({ user in
                    user.id == result.sourceID
                }).first else { return }
                result.authorName = "\(user.firstName) \(user.lastName)"
                result.avatarPath = user.avatar
            }
        }
        DispatchQueue.main.async {
            self.news = newsResponse.news
            self.feedTableView.reloadData()
        }
    }

    private func configureTableView() {
        feedTableView.rowHeight = UITableView.automaticDimension
        feedTableView.register(
            UINib(nibName: Constants.postHeaderNibName, bundle: nil),
            forCellReuseIdentifier: Constants.postHeaderNibName
        )
        feedTableView.register(
            UINib(nibName: Constants.postFooterNibName, bundle: nil),
            forCellReuseIdentifier: Constants.postFooterNibName
        )
        feedTableView.register(
            UINib(nibName: Constants.postTextNibName, bundle: nil),
            forCellReuseIdentifier: Constants.postTextNibName
        )
        feedTableView.register(
            UINib(nibName: Constants.postImageNibName, bundle: nil),
            forCellReuseIdentifier: Constants.postImageNibName
        )
    }

    private func setContentCellID(newsType: NewsType) -> String {
        switch newsType {
        case .post:
            return Constants.postTextNibName
        case .wallPhoto:
            return Constants.postImageNibName
        }
    }
}

// MARK: - UITableViewDataSource.

extension FeedViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        news.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        PostCellType.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellType = PostCellType(rawValue: indexPath.row) else { return UITableViewCell() }
        let post = news[indexPath.section]
        var cellIdentifier = String()
        switch cellType {
        case .header:
            cellIdentifier = Constants.postHeaderNibName
        case .content:
            cellIdentifier = Constants.postTextNibName
        case .footer:
            cellIdentifier = Constants.postFooterNibName
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PostCell
        else { return UITableViewCell() }
        cell.configure(news: post)
        return cell
    }
}
