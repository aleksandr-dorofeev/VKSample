// UIViewController+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Extension with error alert for View Controller.
extension UIViewController {
    // MARK: - Private Constants.

    private enum Constants {
        static let buttonTitleText = "OK"
    }

    // MARK: - Public methods.

    func showErrorAlert(title: String?, message: String?) {
        let alertError = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let actionError = UIAlertAction(title: Constants.buttonTitleText, style: .default, handler: nil)
        alertError.addAction(actionError)
        present(alertError, animated: true)
    }
}
