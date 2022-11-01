// LoginViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Login screen.
final class LoginViewController: UIViewController {
    // MARK: Private Constants.

    private enum Identifiers {
        static let loginSegueID = "friendsSegueID"
    }

    // MARK: Private IBOutlets.

    @IBOutlet var loginContentScrollView: UIScrollView!
    @IBOutlet var loginTextField: UITextField! {
        didSet {
            loginTextField.setLeftPaddingPoints(3)
        }
    }

    @IBOutlet var passwordTextField: UITextField! {
        didSet {
            passwordTextField.setLeftPaddingPoints(3)
        }
    }

    // MARK: - Life cycle.

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createObserversForKeyboard()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObserversForKeyboard()
    }

    // MARK: - Public methods.

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == Identifiers.loginSegueID {
            if checkLogInfo() {
                return true
            } else {
                showLoginError()
                return false
            }
        }
        return true
    }

    // MARK: - Private methods.

    private func createObserversForKeyboard() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShownAction(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHideAction(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(endEditingAction))
        loginContentScrollView.addGestureRecognizer(tapGesture)
    }

    private func removeObserversForKeyboard() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func checkLogInfo() -> Bool {
        guard let loginText = loginTextField.text,
              let passwordText = passwordTextField.text
        else {
            return false
        }
        let verify = Verification()
        if verify.loginVerify(login: loginText, password: passwordText) {
            return true
        } else {
            return false
        }
    }

    @objc private func keyboardWillShownAction(notification: Notification) {
        guard
            let info = notification.userInfo as? NSDictionary,
            let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue)?.cgRectValue.size
        else { return }
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.height, right: 0)
        loginContentScrollView.contentInset = contentInset
        loginContentScrollView.scrollIndicatorInsets = contentInset
    }

    @objc private func keyboardWillHideAction(notification: Notification) {
        loginContentScrollView.contentInset = UIEdgeInsets.zero
        loginContentScrollView.scrollIndicatorInsets = UIEdgeInsets.zero
    }

    @objc private func endEditingAction() {
        loginContentScrollView.endEditing(true)
    }
}

/// UITextFieldDelegate.
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case textField where textField == loginTextField && textField.isFirstResponder:
            passwordTextField.becomeFirstResponder()
        case textField where textField == passwordTextField:
            passwordTextField.resignFirstResponder()
        default:
            break
        }
        return true
    }
}
