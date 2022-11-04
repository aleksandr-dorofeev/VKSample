// LikeControlView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// View with like and amount likes for photo.
@IBDesignable final class LikeControlView: UIControl {
    // MARK: - Private Constants.

    private enum Constants {
        static let heartImageName = "heart"
        static let heartFillImageName = "heart.fill"
        static let redColorName = "Red"
        static let blueColorName = "Blue"
    }

    // MARK: - Private Visual properties.

    private var likeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        return stackView
    }()

    private lazy var amountLikeLabel: UILabel = {
        let label = UILabel()
        label.text = "\(amountLikes)"
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()

    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: Constants.heartImageName), for: .normal)
        button.addTarget(self, action: #selector(likeAction), for: .touchUpInside)
        return button
    }()

    // MARK: - Public properties.

    var amountLikes = 0

    // MARK: - Private properties.

    @IBInspectable private var isLiked: Bool = false {
        didSet {
            updateLikeStatus()
        }
    }

    // MARK: - Life cycle.

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    // MARK: - Public methods.

    override func layoutSubviews() {
        super.layoutSubviews()
        likeStackView.frame = bounds
    }

    // MARK: - Private methods.

    private func setupView() {
        likeStackView = UIStackView(arrangedSubviews: [amountLikeLabel, likeButton])
        addSubview(likeStackView)
    }

    private func setupLikeComponents() {
        amountLikeLabel.text = "\(amountLikes)"
        likeButton.setImage(UIImage(systemName: Constants.heartImageName), for: .normal)
        likeButton.tintColor = UIColor(named: Constants.blueColorName)
    }

    private func setupDislikeComponents() {
        amountLikeLabel.text = "\(amountLikes)"
        likeButton.setImage(UIImage(systemName: Constants.heartFillImageName), for: .normal)
        likeButton.tintColor = UIColor(named: Constants.redColorName)
    }

    private func updateLikeStatus() {
        guard isLiked else {
            amountLikes -= 1
            setupLikeComponents()
            return
        }
        amountLikes += 1
        setupDislikeComponents()
    }

    @objc private func likeAction(_ sender: UIButton) {
        isLiked.toggle()
    }
}
