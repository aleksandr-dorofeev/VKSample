// Verification.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Model for login screen.
struct Verification {
    // MARK: - Private Constant.

    private enum Constants {
        static let userNameText = "admin"
        static let passwordText = "12345"
    }

    // MARK: - Public methods.

    func loginVerify(
        login: String,
        password: String
    ) -> Bool {
        guard
            login == Constants.userNameText,
            password == Constants.passwordText
        else {
            return false
        }
        return true
    }
}
