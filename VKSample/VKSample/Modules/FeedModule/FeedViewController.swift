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
        case image
        case footer
    }

    // MARK: - Private @IBOutlet.

    @IBOutlet private var feedTableView: UITableView!

    // MARK: - Private properties.

    private let vkNetworkService = VKNetworkService()
    private var news: [News] = []
    private var isLoading = false
    private var nextPage: String?

    // MARK: - Life cycle.

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchNewsfeed()
    }

    // MARK: - Private Methods

    private func configureUI() {
        configureTableView()
        createPullRefresh()
    }

    private func fetchNewsfeed() {
        vkNetworkService.fetchNewsfeed { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(items):
                self.fetchFullNews(newsResponse: items)
                self.nextPage = items.nextPage
            case let .failure(error):
                self.showErrorAlert(title: Constants.errorTitleString, message: "\(error.localizedDescription)")
            }
        }
    }

    private func fetchFullNews(newsResponse: VKNewsResponse) {
        newsResponse.news.forEach { result in
            guard result.sourceID < 0
            else {
                filterGroups(newsResponse: newsResponse, result: result)
                return
            }
            filterGroups(newsResponse: newsResponse, result: result)
        }
        DispatchQueue.main.async {
            self.news = newsResponse.news + self.news
            self.feedTableView.reloadData()
            self.feedTableView.refreshControl?.endRefreshing()
        }
    }

    private func filterGroups(newsResponse: VKNewsResponse, result: News) {
        guard let group = newsResponse.groups.filter({ group in
            group.id == (result.sourceID) * -1
        }).first else { return }
        result.authorName = group.name
        result.avatarPath = group.avatar
    }

    private func filterFriends(newsResponse: VKNewsResponse, result: News) {
        guard let friend = newsResponse.friends.filter({ friend in
            friend.id == (result.sourceID) * -1
        }).first else { return }
        result.authorName = "\(friend.firstName) \(friend.lastName)"
        result.avatarPath = friend.avatar
    }

    private func configureTableView() {
        feedTableView.rowHeight = UITableView.automaticDimension
        feedTableView.prefetchDataSource = self
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

    private func createPullRefresh() {
        feedTableView.refreshControl = UIRefreshControl()
        feedTableView.refreshControl?.tintColor = .gray
        feedTableView.refreshControl?.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
    }

//    private func setContentCellID(newsType: NewsType) -> String {
//        switch newsType {
//        case .post:
//            return Constants.postTextNibName
//        case .wallPhoto, .photo:
//            return Constants.postImageNibName
//        }
//    }

    private func fetchLastNews() {
        let firstNewsDate = news.first?.date ?? 0
        vkNetworkService.fetchNewsfeed(startTime: firstNewsDate + 1) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(items):
                self.fetchFullNews(newsResponse: items)
            case let .failure(error):
                self.showErrorAlert(title: Constants.errorTitleString, message: "\(error.localizedDescription)")
            }
        }
    }

    private func fetchOldNews(page: String) {
        vkNetworkService.fetchNewsfeed(page: page) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(items):
                let oldNewsCount = self.news.count
                let newSections = (oldNewsCount ..< (oldNewsCount + items.news.count)).map { $0 }
                self.news.append(contentsOf: items.news)
                self.feedTableView.insertSections(IndexSet(newSections), with: .automatic)
                self.isLoading = false
            case let .failure(error):
                self.showErrorAlert(title: Constants.errorTitleString, message: "\(error.localizedDescription)")
            }
        }
    }

    @objc private func refreshAction() {
        feedTableView.refreshControl?.beginRefreshing()
        fetchLastNews()
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
        case .image:
            cellIdentifier = Constants.postImageNibName
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

// MARK: - UITableViewDataSourcePrefetching.

extension FeedViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard
            let maxRow = indexPaths.map(\.section).max(),
            maxRow > news.count - 3,
            isLoading == false,
            let page = nextPage
        else { return }
        isLoading = true
        fetchOldNews(page: page)
    }
}
