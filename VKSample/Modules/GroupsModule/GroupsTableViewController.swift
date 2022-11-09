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

    // MARK: - Private @IBOutlets.

    @IBOutlet private var searchBar: UISearchBar!

    // MARK: - Private properties.

    private var groups = Groups.getGroups()
    private var subscribedGroupHandler: GroupHandler?
    private var filteredGroups: [Group]? = []
    private var isSearching = false
    private var searchBarIsEmpty: Bool {
        guard let text = searchBar.text else { return false }
        return text.isEmpty
    }

    private var isFiltering: Bool {
        isSearching && !searchBarIsEmpty
    }

    // MARK: - Life cycle.

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableHeaderView()
    }

    // MARK: - Public methods.

    func configure(myGroups: [Group], completion: @escaping GroupHandler) {
        groups = groups.filter { group in
            !myGroups.contains { myGroup in
                myGroup == group
            }
        }
        subscribedGroupHandler = completion
    }

    // MARK: - Private methods.

    private func configureTableHeaderView() {
        tableView.tableHeaderView = searchBar
    }

    private func filterContentForSearch(_ searchText: String) {
        isSearching = true
        filteredGroups = groups.filter {
            $0.name.lowercased().contains(searchText.lowercased())
        }
    }

    // MARK: - Private @IBAction.

    @IBAction private func subscribeAction(_ sender: UIButton) {
        guard
            let indexPath = tableView.indexPathForSelectedRow,
            let group = isFiltering ? filteredGroups?[indexPath.row] : groups[indexPath.row]
        else {
            return
        }
        tableView.beginUpdates()
        sender.isHidden = true
        subscribedGroupHandler?(group)
        tableView.endUpdates()
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITableViewDataSource.

extension GroupsTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredGroups?.count ?? 0
        } else {
            return groups.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let groupCell = tableView.dequeueReusableCell(
                withIdentifier: Constants.groupsCellID,
                for: indexPath
            ) as? GroupTableViewCell,
            let group = isFiltering ? filteredGroups?[indexPath.row] : groups[indexPath.row]
        else { return UITableViewCell() }
        groupCell.configure(with: group)
        return groupCell
    }
}

// MARK: - UISearchBarDelegate.

extension GroupsTableViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterContentForSearch(searchText)
        tableView.reloadData()
    }
}
