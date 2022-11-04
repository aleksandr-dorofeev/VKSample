// ShadowAvatarView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Shadow view for avatar.
@IBDesignable final class ShadowAvatarView: UIView {
    // MARK: - Public Properties.

    @IBInspectable var shadowRadius: CGFloat = 50 {
        didSet {
            updateShadowRadius()
        }
    }

    @IBInspectable var shadowOpacity: CGFloat = 1 {
        didSet {
            updateShadowOpacity()
        }
    }

    @IBInspectable var shadowColor: UIColor = .black {
        didSet {
            updateShadowColor()
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
    }

    private func updateShadowRadius() {
        layer.shadowRadius = shadowRadius
    }

    private func updateShadowOpacity() {
        layer.shadowOpacity = Float(shadowOpacity)
    }

    private func updateShadowColor() {
        layer.shadowColor = shadowColor.cgColor
    }
}
