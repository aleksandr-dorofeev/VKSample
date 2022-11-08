// PostTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Cell with post
final class PostTableViewCell: UITableViewCell {
    // MARK: - Private Constants.

    private enum Constants {
        static let viewColorName = "ViewColor"
        static let blueColorName = "Blue"
    }

    private enum Identifiers {
        static let postImageCollectionViewCellID = "PostImageCollectionViewCell"
    }

    // MARK: - Private @IBOutlet.

    @IBOutlet private var backgroundCustomView: UIView!
    @IBOutlet private var profileNameLabel: UILabel!
    @IBOutlet private var profileImageView: UIImageView!
    @IBOutlet private var postingTimeLabel: UILabel!
    @IBOutlet private var postTextView: UITextView!
    @IBOutlet private var imagePostCollectionView: UICollectionView!

    // MARK: - Private properties.

    private var postImages: [String] = []

    // MARK: - Life cycle.

    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    // MARK: - Public methods.

    func configure(post: Post, viewHight: CGFloat) {
        profileNameLabel.text = post.profileName
        profileImageView.image = UIImage(named: post.profileImageName)
        postingTimeLabel.text = post.publicationDate
        postTextView.text = post.postText
        postImages = post.imageNames
        imagePostCollectionView.translatesAutoresizingMaskIntoConstraints = false
        imagePostCollectionView.heightAnchor.constraint(equalToConstant: viewHight).isActive = true
    }

    // MARK: - Private methods.

    private func configureUI() {
        configureImageView()
        configureBackgroundView()
        registerCellForImagePostCollectionView()
    }

    private func registerCellForImagePostCollectionView() {
        imagePostCollectionView.dataSource = self
        imagePostCollectionView.register(
            UINib(nibName: Identifiers.postImageCollectionViewCellID, bundle: nil),
            forCellWithReuseIdentifier: Identifiers.postImageCollectionViewCellID
        )
    }

    private func configureImageView() {
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        profileImageView.layer.borderWidth = 2
        profileImageView.layer.borderColor = UIColor(named: Constants.blueColorName)?.cgColor
    }

    private func configureBackgroundView() {
        backgroundCustomView.layer.cornerRadius = 15
        backgroundCustomView.backgroundColor = UIColor(named: Constants.viewColorName)
    }
}

// MARK: - UICollectionViewDataSource.

extension PostTableViewCell: UICollectionViewDelegateFlowLayout {}

extension PostTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        postImages.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Identifiers.postImageCollectionViewCellID,
                for: indexPath
            ) as? PostImageCollectionViewCell
        else { return UICollectionViewCell() }
        let postImage = postImages[indexPath.row]
        cell.configure(postImageName: postImage)
        return cell
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        if postImages.count == 1 {
            return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.width)
        } else {
            return CGSize(width: collectionView.bounds.width / 2, height: collectionView.bounds.width / 2)
        }
    }
}
