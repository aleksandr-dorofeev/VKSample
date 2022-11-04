// GroupsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Screen with groups list.
final class GroupsTableViewController: UITableViewController {
    typealias GroupHandler = (Group) -> ()

    // MARK: - Private Constants.

    private enum Constants {
        static let groupsCellID = "GroupCell"
    }

    // MARK: - Private properties.

    private var groups = Groups.getGroups()
    private var subscribedGroupHandler: GroupHandler?

    // MARK: - Public methods.

    func configure(myGroups: [Group], completion: @escaping GroupHandler) {
        groups = groups.filter { group in
            !myGroups.contains { myGroup in
                myGroup == group
            }
        }
        subscribedGroupHandler = completion
    }

    // MARK: - Private @IBAction.

    @IBAction private func subscribeAction(_ sender: UIButton) {
        if let indexPath = tableView.indexPathForSelectedRow {
            let group = groups[indexPath.row]
            subscribedGroupHandler?(group)
            tableView.beginUpdates()
            sender.isHidden = true
            tableView.endUpdates()
        }
    }
}

// MARK: - UITableViewDataSource.

extension GroupsTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let groupCell = tableView.dequeueReusableCell(
            withIdentifier: Constants.groupsCellID,
            for: indexPath
        ) as? GroupTableViewCell else { return UITableViewCell() }
        let group = groups[indexPath.row]
        groupCell.configure(with: group)
        return groupCell
    }
}
