// UITextField+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Extension for left indent for text into textField.
extension UITextField {
    func setLeftPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: frame.size.height))
        leftView = paddingView
        leftViewMode = .always
    }
}
