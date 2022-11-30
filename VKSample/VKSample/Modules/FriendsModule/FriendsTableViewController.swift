// FriendsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift
import UIKit

/// Screen with friends list.
final class FriendsTableViewController: UITableViewController {
    // MARK: - Private Constants.

    private enum Constants {
        static let friendsCellID = "FriendsCell"
        static let photosGallerySegueID = "PhotosGallerySegue"
        static let userIDText = "user_id"
        static let errorTitleString = "Ошибка"
    }

    // MARK: - Private properties.

    private let networkService = VKNetworkService()
    private let realmService = RealmService()

    private var friendsToken: NotificationToken?
    private var friends: Results<Friend>?
    private var sectionsMap: [Character: [Friend]] = [:]
    private var sectionTitles: [Character] = []

    // MARK: - Life cycle.

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCellsToSections()
        fetchFriends()
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

    private func fetchFriends() {
        guard let objects = realmService.readData(items: Friend.self) else { return }
        if !objects.isEmpty {
            friends = objects
            setupCellsToSections()
        } else {
            networkService.fetchFriends { [weak self] result in
                guard
                    let self = self,
                    let friends = self.friends
                else { return }
                switch result {
                case .success:
                    self.createFriendsNotificationToken(resultFriends: friends)
                case let .failure(error):
                    self.showErrorAlert(title: Constants.errorTitleString, message: "\(error.localizedDescription)")
                }
            }
        }
    }

    private func createFriendsNotificationToken(resultFriends: Results<Friend>) {
        friendsToken = friends?.observe { [weak self] change in
            guard let self = self else { return }
            switch change {
            case .initial:
                break
            case .update:
                self.friends = resultFriends
                self.tableView.reloadData()
                self.setupCellsToSections()
            case let .error(error):
                print(error.localizedDescription)
            }
        }
    }

    private func setupCellsToSections() {
        guard let friends = friends else { return }
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
        cell.configure(with: friend)
        return cell
    }
}
