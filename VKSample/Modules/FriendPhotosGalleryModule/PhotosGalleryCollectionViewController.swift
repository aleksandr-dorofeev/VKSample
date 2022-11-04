// PhotosGalleryCollectionViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Screen with friend's photos gallery.
final class PhotosGalleryCollectionViewController: UICollectionViewController {
    // MARK: - Private Constants.

    private enum Constants {
        static let friendPhotosGalleryID = "FriendPhotoCell"
    }

    // MARK: - Private @IBOutlet.

    @IBOutlet private var photosGalleryCollectionView: UICollectionView!

    // MARK: - Private properties.

    private var photoInGalleryNames: [String] = []

    // MARK: - Life cycle.

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - Public methods.

    func getPhotosGallery(by gallery: [String]) {
        photoInGalleryNames = gallery
    }

    // MARK: - Private methods.

    private func configureUI() {
        configureCollectionCellLayout()
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

/// Data source.
extension PhotosGalleryCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photoInGalleryNames.count
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let photoCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.friendPhotosGalleryID,
            for: indexPath
        ) as? FriendPhotoGalleryCollectionViewCell else { return UICollectionViewCell() }
        photoCell.configure(imageName: photoInGalleryNames[indexPath.row])
        return photoCell
    }
}
