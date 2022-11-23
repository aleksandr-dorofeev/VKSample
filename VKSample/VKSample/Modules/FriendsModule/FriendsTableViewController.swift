// FriendsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Screen with friends list.
final class FriendsTableViewController: UITableViewController {
    // MARK: - Private Constants.

    private enum Constants {
        static let friendsCellID = "FriendsCell"
        static let photosGallerySegueID = "PhotosGallerySegue"
    }

    // MARK: - Private properties.

    private let friends = Friends.getFriends()
    private var sectionsMap: [Character: [Friend]] = [:]
    private var sectionTitles: [Character] = []

    // MARK: - Life cycle.

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCellsToSections()
    }

    // MARK: - Public methods.

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Constants.photosGallerySegueID,
              let photosGalleryVC = segue.destination as? PhotosGalleryCollectionViewController,
              let indexPath = tableView.indexPathForSelectedRow,
              let friendPhotos = sectionsMap[sectionTitles[indexPath.section]]?[indexPath.row].profileImageNames
        else {
            return
        }
        photosGalleryVC.getPhotosGallery(by: friendPhotos)
    }

    // MARK: - Private methods.

    private func setupCellsToSections() {
        for friend in friends {
            guard let firstLetterOfFirstName = friend.name.firstName.first else { return }
            let firstLetter = friend.name.lastName?.first ?? firstLetterOfFirstName
            if sectionsMap[firstLetter] != nil {
                sectionsMap[firstLetter]?.append(friend)
            } else {
                sectionsMap[firstLetter] = [friend]
            }
        }
        sectionTitles = Array(sectionsMap.keys).sorted()
        tableView.reloadData()
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
