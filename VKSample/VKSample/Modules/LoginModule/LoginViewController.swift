// LoginViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Login screen.
final class LoginViewController: UIViewController {
    // MARK: Private Constants.

    private enum Identifiers {
        static let loginSegueID = "friendsSegueID"
    }

    private enum Constants {
        static let titleText = "Ошибка"
        static let messageText = "Логин и/или пароль не верны"
    }

    // MARK: Private IBOutlets.

    @IBOutlet private var loginContentScrollView: UIScrollView!
    @IBOutlet private var loginTextField: UITextField! {
        didSet {
            loginTextField.setLeftPaddingPoints(3)
        }
    }

    @IBOutlet private var passwordTextField: UITextField! {
        didSet {
            passwordTextField.setLeftPaddingPoints(3)
        }
    }

    @IBOutlet private var firstLoaderView: UIView! {
        didSet {
            firstLoaderView.layer.cornerRadius = firstLoaderView.frame.width / 2
        }
    }

    @IBOutlet private var secondLoaderView: UIView! {
        didSet {
            secondLoaderView.layer.cornerRadius = secondLoaderView.frame.width / 2
        }
    }

    @IBOutlet private var thirdLoaderView: UIView! {
        didSet {
            thirdLoaderView.layer.cornerRadius = thirdLoaderView.frame.width / 2
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

    private func loadEntryAnimation() {
        UIView.animateKeyframes(
            withDuration: 4,
            delay: 0,
            options: [],
            animations: {
                UIView.addKeyframe(
                    withRelativeStartTime: 0,
                    relativeDuration: 0.4,
                    animations: {
                        self.firstLoaderView.alpha = 1
                    }
                )
                UIView.addKeyframe(
                    withRelativeStartTime: 0.35,
                    relativeDuration: 0.65,
                    animations: {
                        self.secondLoaderView.alpha = 1
                    }
                )
                UIView.addKeyframe(
                    withRelativeStartTime: 0.7,
                    relativeDuration: 1,
                    animations: {
                        self.thirdLoaderView.alpha = 1
                    }
                )
            },
            completion: { _ in
                self.performSegue(withIdentifier: Identifiers.loginSegueID, sender: self)
            }
        )
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

    // MARK: - Private @IBAction.

    @IBAction private func entryLoginAction(_ sender: Any) {
        if checkLogInfo() {
            loadEntryAnimation()
        } else {
            showErrorAlert(title: Constants.titleText, message: Constants.messageText)
        }
    }
}

// MARK: - UITextFieldDelegate.

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
