// MainNavigationController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Navigation controller with animate transition.
final class MainNavigationController: UINavigationController {
    // MARK: - Private properties.

    private let interactiveTransition = InteractiveTransition()

    // MARK: - Life cycle.

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationController()
    }

    // MARK: - Private methods.

    private func configureNavigationController() {
        delegate = self
    }
}

// MARK: - UINavigationControllerDelegate.

extension MainNavigationController: UINavigationControllerDelegate {
    // MARK: - Public methods.

    func navigationController(
        _ navigationController: UINavigationController,
        interactionControllerFor animationController:
        UIViewControllerAnimatedTransitioning
    ) -> UIViewControllerInteractiveTransitioning? {
        interactiveTransition.isStarted ? interactiveTransition : nil
    }

    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push:
            interactiveTransition.viewController = toVC
            return PushTransitionAnimator()
        case .pop:
            if navigationController.viewControllers.first != toVC {
                interactiveTransition.viewController = toVC
            }
            return PopTransitionAnimator()
        default:
            return nil
        }
    }
}
