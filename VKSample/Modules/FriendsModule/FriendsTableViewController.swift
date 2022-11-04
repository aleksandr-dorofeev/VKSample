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
    private var sections: [Character: [Friend]] = [:]
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
              let friendPhotos = sections[sectionTitles[indexPath.section]]?[indexPath.row].profileImageNames
        else {
            return
        }
        photosGalleryVC.getPhotosGallery(by: friendPhotos)
    }

    // MARK: - Private methods.

    private func setupCellsToSections() {
        for friend in friends {
            guard let firstLetter = friend.name.first else { return }
            if sections[firstLetter] != nil {
                sections[firstLetter]?.append(friend)
            } else {
                sections[firstLetter] = [friend]
            }
        }
        sectionTitles = Array(sections.keys).sorted()
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource.

extension FriendsTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[sectionTitles[section]]?.count ?? 0
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }

    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        sectionTitles.compactMap { String($0) }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        String(sectionTitles[section])
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.friendsCellID,
                for: indexPath
            ) as? FriendTableViewCell,
            let friend = sections[sectionTitles[indexPath.section]]?[indexPath.row]
        else { return UITableViewCell() }
        cell.configure(with: friend)
        return cell
    }
}
