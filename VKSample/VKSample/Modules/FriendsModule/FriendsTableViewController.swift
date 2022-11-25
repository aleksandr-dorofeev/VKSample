// FriendsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Screen with friends list.
final class FriendsTableViewController: UITableViewController {
    // MARK: - Private Constants.

    private enum Constants {
        static let friendsCellID = "FriendsCell"
        static let photosGallerySegueID = "PhotosGallerySegue"
        static let userIDText = "user_id"
    }

    // MARK: - Private properties.

    private let networkService = VKNetworkService()

    private var friends: [ItemFriend] = []
    private var sectionsMap: [Character: [ItemFriend]] = [:]
    private var sectionTitles: [Character] = []

    // MARK: - Life cycle.

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCellsToSections()
        getFriends()
        print(friends)
    }

    // MARK: - Public methods.

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Constants.photosGallerySegueID,
              let photosGalleryVC = segue.destination as? PhotosGalleryCollectionViewController,
              let indexPath = tableView.indexPathForSelectedRow,
              let friend = sectionsMap[sectionTitles[indexPath.section]]?[indexPath.row]
        else {
            return
        }
        photosGalleryVC.configure(by: friend)
    }

    // MARK: - Private methods.

    private func getFriends() {
        networkService.fetchFriends { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(users):
                let items = users.response.items
                self.friends = items
                self.setupCellsToSections()
                self.tableView.reloadData()
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }

    private func setupCellsToSections() {
        for friend in friends {
            guard let firstLetterOfFirstName = friend.firstName.first else { return }
            let firstLetter = friend.lastName.first ?? firstLetterOfFirstName
            if sectionsMap[firstLetter] != nil {
                sectionsMap[firstLetter]?.append(friend)
            } else {
                sectionsMap[firstLetter] = [friend]
            }
        }
        sectionTitles = Array(sectionsMap.keys).sorted()
    }
}

// MARK: - UITableViewDataSource.

extension FriendsTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sectionsMap[sectionTitles[section]]?.count ?? 0
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        sectionsMap.count
    }

    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        sectionTitles.compactMap { String($0) }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        String(sectionTitles[section])
    }

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let view = view as? UITableViewHeaderFooterView else { return }
        view.textLabel?.textColor = .darkGray.withAlphaComponent(0.3)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.friendsCellID,
                for: indexPath
            ) as? FriendTableViewCell,
            let friend = sectionsMap[sectionTitles[indexPath.section]]?[indexPath.row]
        else { return UITableViewCell() }
        print(friend)
        cell.configure(with: friend)
        return cell
    }
}
