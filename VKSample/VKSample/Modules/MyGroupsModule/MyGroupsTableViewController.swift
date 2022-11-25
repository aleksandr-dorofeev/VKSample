// MyGroupsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Screen with my groups.
final class MyGroupsTableViewController: UITableViewController {
    // MARK: - Private Constants.

    private enum Constants {
        static let myGroupsCellID = "MyGroupCell"
        static let groupsSegueID = "GroupsSegue"
        static let userIDText = "user_id"
    }

    // MARK: - Private properties.

    private let networkService = VKNetworkService()

    private var myGroups: [ItemGroup] = []

    // MARK: - Life cycle.

    override func viewDidLoad() {
        super.viewDidLoad()
        getUsersGroups()
    }

    // MARK: - Private methods.

    private func getUsersGroups() {
        networkService.fetchUsersGroups { [weak self] result in
            switch result {
            case let .success(groups):
                let items = groups.response.items
                self?.myGroups = items
                self?.tableView.reloadData()
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - UITableViewDataSource.

extension MyGroupsTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let groupCell = tableView.dequeueReusableCell(
            withIdentifier: Constants.myGroupsCellID,
            for: indexPath
        ) as? MyGroupTableViewCell else { return UITableViewCell() }
        let group = myGroups[indexPath.row]
        groupCell.configure(with: group)
        return groupCell
    }
}

// MARK: - UITableViewDelegate.

extension MyGroupsTableViewController {
    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        switch editingStyle {
        case .delete:
            myGroups.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        default:
            break
        }
    }
}
