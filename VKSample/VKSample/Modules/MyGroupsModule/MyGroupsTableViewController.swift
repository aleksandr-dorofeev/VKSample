// MyGroupsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift
import UIKit

/// Screen with my groups.
final class MyGroupsTableViewController: UITableViewController {
    // MARK: - Private Constants.

    private enum Constants {
        static let myGroupsCellID = "MyGroupCell"
        static let groupsSegueID = "GroupsSegue"
        static let userIDText = "user_id"
        static let errorTitleString = "Ошибка"
    }

    // MARK: - Private properties.

    private let networkService = VKNetworkService()
    private let realmService = RealmService()
    private var groupsToken: NotificationToken?

    private var groups: Results<Group>?

    // MARK: - Life cycle.

    override func viewDidLoad() {
        super.viewDidLoad()
        getUsersGroups()
    }

    // MARK: - Private methods.

    private func getUsersGroups() {
        guard let objects = realmService.readData(items: Group.self) else { return }
        if !objects.isEmpty {
            groups = objects
            tableView.reloadData()
        } else {
            networkService.fetchUsersGroups { [weak self] result in
                guard
                    let self = self,
                    let groups = self.groups
                else { return }
                switch result {
                case .success:
                    self.createGroupNotificationToken(resultGroups: groups)
                case let .failure(error):
                    self.showErrorAlert(title: Constants.errorTitleString, message: "\(error.localizedDescription)")
                }
            }
        }
    }

    private func createGroupNotificationToken(resultGroups: Results<Group>) {
        groupsToken = groups?.observe { [weak self] change in
            guard let self = self else { return }
            switch change {
            case .initial:
                break
            case .update:
                self.groups = resultGroups
                self.tableView.reloadData()
            case let .error(error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - UITableViewDataSource.

extension MyGroupsTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groups?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let groupCell = tableView.dequeueReusableCell(
                withIdentifier: Constants.myGroupsCellID,
                for: indexPath
            ) as? MyGroupTableViewCell,
            let group = groups?[indexPath.row]
        else { return UITableViewCell() }
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
        guard let group = groups?[indexPath.row],
              editingStyle == .delete else { return }
        realmService.deleteGroup(group)
        tableView.reloadData()
    }
}
