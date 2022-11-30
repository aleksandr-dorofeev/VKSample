// SwipeUserPhotosViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Screen with user photos that scroll through the swipe.
final class SwipeUserPhotosViewController: UIViewController {
    // MARK: - Private enums.

    private enum TypeSwipes {
        case left
        case right
    }

    // MARK: - Private IBOutlets.

    @IBOutlet private var currentImageView: UIImageView!
    @IBOutlet private var nextImageView: UIImageView!
    @IBOutlet private var nextImageTrailingConstraint: NSLayoutConstraint!
    @IBOutlet private var nextImageLeadingConstraint: NSLayoutConstraint!
    @IBOutlet private var nextImageTopConstraint: NSLayoutConstraint!
    @IBOutlet private var nextImageBottomConstraint: NSLayoutConstraint!
    @IBOutlet private var currentImageTrailingConstraint: NSLayoutConstraint!
    @IBOutlet private var currentImageLeadingConstraint: NSLayoutConstraint!
    @IBOutlet private var currentImageTopConstraint: NSLayoutConstraint!
    @IBOutlet private var currentImageBottomConstraint: NSLayoutConstraint!

    // MARK: - Private properties.

    private var photos: [Photo] = []
    private var currentPhotoIndex = 0

    // MARK: - Life cycle.

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Public methods.

    func configurePhotosUserVC(photoGalleryNames: [Photo], currentPhotoIndex: Int) {
        photos = photoGalleryNames
        self.currentPhotoIndex = currentPhotoIndex
    }

    // MARK: - Private methods.

    private func setupUI() {
        createSwipeOnView()
        configureImageViews()
    }

    private func prepareAnimation(typeOfSwipe: TypeSwipes) {
        configureStartPositionForCurrentImage()
        switch typeOfSwipe {
        case .left:
            prepareAnimationForLeftSwipe()
        case .right:
            prepareAnimationForRightSwipe()
        }
        view.layoutIfNeeded()
    }

    private func prepareAnimationForRightSwipe() {
        currentImageView.layer.zPosition = 1
        ImageLoader.shared.setImage(
            userPhotoURLText: photos[currentPhotoIndex].url,
            imageView: currentImageView
        )
        nextImageTrailingConstraint.constant = 100
        nextImageLeadingConstraint.constant = 100
        nextImageTopConstraint.constant = 200
        nextImageBottomConstraint.constant = -200
        nextImageView.layer.zPosition = 1
        ImageLoader.shared.setImage(
            userPhotoURLText: photos[currentPhotoIndex - 1].url,
            imageView: nextImageView
        )
        currentPhotoIndex -= 1
    }

    private func prepareAnimationForLeftSwipe() {
        let viewWidth = view.frame.width
        currentImageView.layer.zPosition = 1
        ImageLoader.shared.setImage(
            userPhotoURLText: photos[currentPhotoIndex].url,
            imageView: currentImageView
        )
        nextImageTrailingConstraint.constant = -viewWidth
        nextImageLeadingConstraint.constant = viewWidth
        nextImageView.layer.zPosition = 2
        ImageLoader.shared.setImage(
            userPhotoURLText: photos[currentPhotoIndex + 1].url,
            imageView: nextImageView
        )
        currentPhotoIndex += 1
    }

    private func configureStartPositionForCurrentImage() {
        currentImageTrailingConstraint.constant = 0
        currentImageLeadingConstraint.constant = 0
        currentImageTopConstraint.constant = 0
        currentImageBottomConstraint.constant = 0
    }

    private func makeSwipeAnimation(
        orientation: TypeSwipes,
        currentTrailingConstraint: CGFloat,
        currentLeadingConstraint: CGFloat
    ) {
        prepareAnimation(typeOfSwipe: orientation)
        UIView.animateKeyframes(withDuration: 1, delay: 0) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                self.currentImageTrailingConstraint.constant = currentTrailingConstraint
                self.currentImageLeadingConstraint.constant = currentLeadingConstraint
                self.currentImageTopConstraint.constant = 200
                self.currentImageBottomConstraint.constant = -200
            }
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                self.configureEndPositionForNextImage()
            }
            self.view.layoutIfNeeded()
        }
    }

    private func configureEndPositionForNextImage() {
        nextImageTrailingConstraint.constant = 0
        nextImageLeadingConstraint.constant = 0
        nextImageTopConstraint.constant = 0
        nextImageBottomConstraint.constant = 0
    }

    private func createSwipeOnView() {
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureRecognizerAction))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureRecognizerAction))
        rightSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)
    }

    private func configureImageViews() {
        ImageLoader.shared.setImage(
            userPhotoURLText: photos[currentPhotoIndex].url,
            imageView: currentImageView
        )
    }

    @objc private func swipeGestureRecognizerAction(gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .right:
            guard
                currentPhotoIndex < photos.count,
                currentPhotoIndex > 0
            else { return }
            let viewWidth = view.frame.width
            makeSwipeAnimation(
                orientation: .right,
                currentTrailingConstraint: -viewWidth,
                currentLeadingConstraint: viewWidth
            )
        case .left:
            guard
                currentPhotoIndex < photos.count - 1,
                currentPhotoIndex >= 0
            else { return }
            makeSwipeAnimation(
                orientation: .left,
                currentTrailingConstraint: 100,
                currentLeadingConstraint: 100
            )
        default:
            break
        }
    }
}
