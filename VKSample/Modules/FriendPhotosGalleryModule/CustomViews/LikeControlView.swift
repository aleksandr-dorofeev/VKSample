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
        stackView.spacing = 5
        return stackView
    }()

    private lazy var amountLikeLabel: UILabel = {
        let label = UILabel()
        label.text = "\(amountLikes)"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .systemBlue
        return label
    }()

    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: Constants.heartImageName), for: .normal)
        button.addTarget(self, action: #selector(likeAction), for: .touchUpInside)
        return button
    }()

    // MARK: - Private properties.

    private var amountLikes = 0

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

    func configureAmountLikes(amount: Int) {
        amountLikes = amount
    }

    // MARK: - Private methods.

    private func setupView() {
        likeStackView = UIStackView(arrangedSubviews: [likeButton, amountLikeLabel])
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
