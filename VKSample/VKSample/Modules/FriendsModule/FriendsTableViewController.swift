// FriendsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import PromiseKit
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

    private let promiseService = PromiseService()
    private var imageService: ImageService?
    private var friendsToken: NotificationToken?
    private var friends: Results<Friend>?
    private var sectionsMap: [Character: [Friend]] = [:]
    private var sectionTitles: [Character] = []

    // MARK: - Life cycle.

    override func viewDidLoad() {
        super.viewDidLoad()
        loadFriends()
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

    private func loadFriends() {
        guard let objects = RealmService.readData(Friend.self) else { return }
        addFriendToken(result: objects)
        friends = objects
        setupCellsToSections()
        fetchPromiseFriends()
        imageService = ImageService(container: self)
    }

    private func fetchPromiseFriends() {
        firstly {
            promiseService.friendsRequest()
        }.done { friends in
            RealmService.writeData(items: friends.items)
        }.catch { [weak self] error in
            self?.showErrorAlert(title: Constants.errorTitleString, message: "\(error.localizedDescription)")
        }
    }

    private func addFriendToken(result: Results<Friend>) {
        friendsToken = result.observe { [weak self] change in
            guard let self = self else { return }
            switch change {
            case .initial:
                break
            case .update:
                self.friends = result
                self.setupCellsToSections()
                self.tableView.reloadData()
            case let .error(error):
                self.showErrorAlert(title: Constants.errorTitleString, message: "\(error.localizedDescription)")
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
            let friend = sectionsMap[sectionTitles[indexPath.section]]?[indexPath.row],
            let imageService = imageService
        else { return UITableViewCell() }
        cell.configure(service: imageService, with: friend)
        return cell
    }
}
