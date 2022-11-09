// ShadowAvatarView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Shadow view for avatar.
@IBDesignable final class ShadowAvatarView: UIView {
    // MARK: - Private Constant.

    private enum Constants {
        static let transformKeyPathText = "transform.scale"
    }

    // MARK: - Private Properties.

    @IBInspectable private var shadowRadius: CGFloat = 50 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }

    @IBInspectable private var shadowOpacity: CGFloat = 1 {
        didSet {
            layer.shadowOpacity = Float(shadowOpacity)
        }
    }

    @IBInspectable private var shadowColor: UIColor = .black {
        didSet {
            layer.shadowColor = shadowColor.cgColor
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

    // MARK: - Private Methods

    private func setupView() {
        backgroundColor = .white
        layer.cornerRadius = frame.width / 2
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 10
        layer.shadowOffset = CGSize.zero
        layer.masksToBounds = false
        createTapGestureRecognizer()
    }

    private func createTapGestureRecognizer() {
        isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(avatarAnimationAction))
        addGestureRecognizer(tapGesture)
    }

    @objc private func avatarAnimationAction() {
        let animation = CASpringAnimation(keyPath: Constants.transformKeyPathText)
        animation.fromValue = 0.1
        animation.toValue = 1
        animation.stiffness = 50
        animation.mass = 2
        animation.duration = 4
        animation.fillMode = .forwards
        layer.add(animation, forKey: nil)
    }
}
