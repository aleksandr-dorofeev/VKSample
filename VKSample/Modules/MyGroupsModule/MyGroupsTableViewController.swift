// MyGroupsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Screen with my groups.
final class MyGroupsTableViewController: UITableViewController {
    // MARK: - Private Constants.

    private enum Constants {
        static let myGroupsCellID = "MyGroupCell"
        static let groupsSegueID = "GroupsSegue"
    }

    // MARK: - Private properties.

    private var myGroups: [Group] = []

    // MARK: - Public methods

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Constants.groupsSegueID,
              let groupsVC = segue.destination as? GroupsTableViewController else { return }
        groupsVC.configure(myGroups: myGroups) { [weak self] addedGroup in
            guard let self = self else { return }
            self.myGroups.append(addedGroup)
            self.tableView.reloadData()
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
