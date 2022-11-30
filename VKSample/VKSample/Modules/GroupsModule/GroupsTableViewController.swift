// GroupsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Screen with groups list.
final class GroupsTableViewController: UITableViewController {
    typealias GroupHandler = (Group) -> ()

    // MARK: - Private Constants.

    private enum Constants {
        static let groupsCellID = "GroupCell"
        static let errorTitleString = "Ошибка"
    }

    // MARK: - Private @IBOutlets.

    @IBOutlet private var searchBar: UISearchBar!

    // MARK: - Private properties.

    private let vkNetworkService = VKNetworkService()
    private var filteredGroups: [Group] = []

    // MARK: - Life cycle.

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableHeaderView()
    }

    // MARK: - Private methods.

    private func fetchSearchedGroups(text: String) {
        vkNetworkService.fetchSearchedGroups(text: text) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(result):
                let groups = result
                self.filteredGroups = groups
                self.tableView.reloadData()
            case let .failure(error):
                self.showErrorAlert(title: Constants.errorTitleString, message: "\(error.localizedDescription)")
            }
        }
    }

    private func configureTableHeaderView() {
        tableView.tableHeaderView = searchBar
    }
}

// MARK: - UITableViewDataSource.

extension GroupsTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let groupCell = tableView.dequeueReusableCell(
                withIdentifier: Constants.groupsCellID,
                for: indexPath
            ) as? GroupTableViewCell
        else { return UITableViewCell() }
        let group = filteredGroups[indexPath.row]
        groupCell.configure(with: group)
        return groupCell
    }
}

// MARK: - UISearchBarDelegate.

extension GroupsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredGroups.removeAll()
        guard !searchText.isEmpty else {
            tableView.reloadData()
            return
        }
        fetchSearchedGroups(text: searchText)
    }
}
