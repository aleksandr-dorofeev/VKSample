// GroupsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Screen with groups list.
final class GroupsTableViewController: UITableViewController {
    typealias GroupHandler = (ItemGroup) -> ()

    // MARK: - Private Constants.

    private enum Constants {
        static let groupsCellID = "GroupCell"
    }

    // MARK: - Private @IBOutlets.

    @IBOutlet private var searchBar: UISearchBar!

    // MARK: - Private properties.

    private let networkService = VKNetworkService()
    private var filteredGroups: [ItemGroup] = []

    // MARK: - Life cycle.

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableHeaderView()
    }

    // MARK: - Private methods.

    private func loadSearchedGroups(text: String) {
        networkService.fetchSearchedGroups(text: text) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(result):
                let groups = result.response.items
                self.filteredGroups = groups
                self.tableView.reloadData()
            case let .failure(error):
                print(error.localizedDescription)
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
        loadSearchedGroups(text: searchText)
    }
}
