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

    private let vkNetworkService = VKNetworkService()
    private var groupsToken: NotificationToken?
    private var groups: Results<Group>?

    // MARK: - Life cycle.

    override func viewDidLoad() {
        super.viewDidLoad()
        loadGroups()
    }

    // MARK: - Private methods.

    private func loadGroups() {
        guard let objects = RealmService.readData(Group.self) else { return }
        addGroupToken(result: objects)
        groups = objects
        fetchGroupsOperation()
    }

    private func fetchGroupsOperation() {
        vkNetworkService.fetchOperationalGroups()
    }

    private func fetchGroups() {
        vkNetworkService.fetchUsersGroups { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(groups):
                RealmService.writeData(items: groups)
            case let .failure(error):
                self.showErrorAlert(title: Constants.errorTitleString, message: "\(error.localizedDescription)")
            }
        }
    }

    private func addGroupToken(result: Results<Group>) {
        groupsToken = result.observe { [weak self] change in
            guard let self = self else { return }
            switch change {
            case .initial:
                break
            case .update:
                self.groups = result
                self.tableView.reloadData()
            case let .error(error):
                self.showErrorAlert(title: Constants.errorTitleString, message: "\(error.localizedDescription)")
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
        RealmService.deleteGroup(group)
        tableView.reloadData()
    }
}
