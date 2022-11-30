// PhotosGalleryCollectionViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Screen with friend's photos gallery.
final class PhotosGalleryCollectionViewController: UICollectionViewController {
    // MARK: - Private Constants.

    private enum Constants {
        static let friendPhotosGalleryID = "FriendPhotoCell"
        static let segueToSwipePhotosID = "SwipePhotosSegue"
        static let errorTitleString = "Ошибка"
    }

    // MARK: - Private @IBOutlet.

    @IBOutlet private var photosGalleryCollectionView: UICollectionView!

    // MARK: - Private properties.

    private let networkService = VKNetworkService()
    private var photoURLNames: [String] = []

    private var selectedCellIndex = 0

    // MARK: - Life cycle.

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - Public methods.

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            segue.identifier == Constants.segueToSwipePhotosID,
            let destination = segue.destination as? SwipeUserPhotosViewController
        else { return }
        destination.configurePhotosUserVC(
            photoGalleryNames: photoURLNames,
            currentPhotoIndex: selectedCellIndex
        )
    }

    func configure(by friend: Friend) {
        let friendID = friend.id
        title = "\(friend.firstName) \(friend.lastName)"
        getPhoto(friendID: friendID)
    }

    // MARK: - Private methods.

    private func configureUI() {
        configureCollectionCellLayout()
    }

    private func getPhoto(friendID: Int) {
        networkService.fetchUsersPhoto(ownerID: friendID) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(photoString):
                let photos = photoString
                var photosNames: [String] = []
                for item in photos {
                    photosNames.append(item.url)
                }
                self.photoURLNames = photosNames
                self.collectionView.reloadData()
            case let .failure(error):
                self.showErrorAlert(title: Constants.errorTitleString, message: "\(error.localizedDescription)")
            }
        }
    }

    private func configureCollectionCellLayout() {
        if let layout = photosGalleryCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let cellWidthConstant: CGFloat = 185
            let cellHeightConstant: CGFloat = 185
            layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
            layout.scrollDirection = .vertical
            layout.minimumInteritemSpacing = 1
            layout.minimumLineSpacing = 1
            layout.itemSize = CGSize(width: cellWidthConstant, height: cellHeightConstant)
        }
    }
}

// MARK: - UICollectionViewDataSource.

extension PhotosGalleryCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photoURLNames.count
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let photoCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.friendPhotosGalleryID,
            for: indexPath
        ) as? FriendPhotoGalleryCollectionViewCell else { return UICollectionViewCell() }
        photoCell.configure(imageUrlString: photoURLNames[indexPath.row])
        return photoCell
    }
}

// MARK: - UICollectionViewDelegate.

extension PhotosGalleryCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCellIndex = indexPath.row
        performSegue(withIdentifier: Constants.segueToSwipePhotosID, sender: self)
    }
}
