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

    private let vkNetworkService = VKNetworkService()
    private var friendID = Int()
    private var photos: [Photo] = []
    private var selectedCellIndex = 0

    // MARK: - Life cycle.

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        loadPhotos()
    }

    // MARK: - Public methods.

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            segue.identifier == Constants.segueToSwipePhotosID,
            let destination = segue.destination as? SwipeUserPhotosViewController
        else { return }
        destination.configurePhotosUserVC(
            photoGalleryNames: photos,
            currentPhotoIndex: selectedCellIndex
        )
    }

    func configure(by friend: Friend) {
        friendID = friend.id
        title = "\(friend.firstName) \(friend.lastName)"
    }

    // MARK: - Private methods.

    private func configureUI() {
        configureCollectionCellLayout()
    }

    private func loadPhotos() {
        guard let objects = RealmService.readData(Photo.self) else { return }
        let userId = objects.map(\.ownerID)
        if userId.contains(where: { $0 == friendID }) {
            photos = objects.filter { $0.ownerID == friendID }
        } else {
            fetchPhotos()
        }
    }

    private func fetchPhotos() {
        vkNetworkService.fetchUsersPhoto(ownerID: friendID) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(photos):
                RealmService.writeData(items: photos)
                self.photos = photos
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
        photos.count
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let photoCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.friendPhotosGalleryID,
            for: indexPath
        ) as? FriendPhotoGalleryCollectionViewCell else { return UICollectionViewCell() }
        photoCell.configure(imageUrlString: photos[indexPath.row].url)
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
