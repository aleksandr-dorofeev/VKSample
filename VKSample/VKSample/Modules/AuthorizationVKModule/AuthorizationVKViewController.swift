// AuthorizationVKViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
import WebKit

/// Screen VK authorization.
final class AuthorizationVKViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let httpsSchemeText = "https"
        static let vkHostText = "oauth.vk.com"
        static let authorizePortText = "/authorize"
        static let clientIDParamText = "client_id"
        static let clientIDText = "51496825"
        static let displayParamText = "display"
        static let displayMobileText = "mobile"
        static let redirectUriParamText = "redirect_uri"
        static let redirectUriText = "https://oauth.vk.com/blank.html"
        static let scopeParamText = "scope"
        static let scopeText = "270342"
        static let responseTypeParamText = "response_type"
        static let tokenText = "token"
        static let versionParamText = "v"
        static let versionText = "5.68"
        static let blankHtmlText = "/blank.html"
        static let separatorForParamsText = "&"
        static let signEquallyText = "="
        static let accessTokenText = "access_token"
        static let userPhotoID = 1
        static let testSearchedGroupText = "Кино"
        static let userIDText = "user_id"
        static let segueTabBarID = "showTabBarVC"
    }

    // MARK: - Private @IBOutlet.

    @IBOutlet private var authWKWebView: WKWebView! {
        didSet {
            authWKWebView.navigationDelegate = self
        }
    }

    // MARK: - Private properties.

    private let networkService = VKNetworkService()

    // MARK: - Life cycle.

    override func viewDidLoad() {
        super.viewDidLoad()
        setupURLComponents()
    }

    // MARK: - Private methods.

    private func setupURLComponents() {
        var urlComponents = URLComponents()
        urlComponents.scheme = Constants.httpsSchemeText
        urlComponents.host = Constants.vkHostText
        urlComponents.path = Constants.authorizePortText
        urlComponents.queryItems = [
            URLQueryItem(name: Constants.clientIDParamText, value: Constants.clientIDText),
            URLQueryItem(name: Constants.displayParamText, value: Constants.displayMobileText),
            URLQueryItem(name: Constants.redirectUriParamText, value: Constants.redirectUriText),
            URLQueryItem(name: Constants.scopeParamText, value: Constants.scopeText),
            URLQueryItem(name: Constants.responseTypeParamText, value: Constants.tokenText),
            URLQueryItem(name: Constants.versionParamText, value: Constants.versionText)
        ]
        guard let url = urlComponents.url else { return }
        let request = URLRequest(url: url)
        authWKWebView.load(request)
    }
}

// MARK: - WKNavigationDelegate.

extension AuthorizationVKViewController: WKNavigationDelegate {
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationResponse:
        WKNavigationResponse,
        decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void
    ) {
        guard
            let url = navigationResponse.response.url,
            let fragment = url.fragment,
            url.path == Constants.blankHtmlText
        else {
            decisionHandler(.allow)
            return
        }
        let params = fragment
            .components(separatedBy: Constants.separatorForParamsText)
            .map { $0.components(separatedBy: Constants.signEquallyText) }.reduce(
                [String: String]()
            ) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        let token = params[Constants.accessTokenText]
        let userID = params[Constants.userIDText]
        guard
            let token = token,
            let userID = userID,
            let secureUserID = Int(userID)
        else {
            return
        }
        Session.shared.token = token
        Session.shared.userID = secureUserID
        decisionHandler(.cancel)
        performSegue(withIdentifier: Constants.segueTabBarID, sender: self)
    }
}
