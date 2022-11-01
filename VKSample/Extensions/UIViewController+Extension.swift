// UIViewController+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Extension with error alert for View Controller.
extension UIViewController {
    // MARK: - Private Constants.

    private enum Constants {
        static let titleText = "Ошибка"
        static let messageText = "Логин и/или пароль не верны"
        static let buttonTitleText = "OK"
    }

    // MARK: - Public methods.

    func showLoginError() {
        let alertError = UIAlertController(
            title: Constants.titleText,
            message: Constants.messageText,
            preferredStyle: .alert
        )
        let actionError = UIAlertAction(title: Constants.buttonTitleText, style: .default, handler: nil)
        alertError.addAction(actionError)
        present(alertError, animated: true)
    }
}
