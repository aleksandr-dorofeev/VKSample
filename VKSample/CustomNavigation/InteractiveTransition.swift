// InteractiveTransition.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Interactive transition animation.
final class InteractiveTransition: UIPercentDrivenInteractiveTransition {
    // MARK: - Public properties.

    var viewController: UIViewController? {
        didSet {
            let panRecognizer = UIScreenEdgePanGestureRecognizer(
                target: self,
                action: #selector(handleScreenEdgeGestureAction)
            )
            panRecognizer.edges = [.left]
            viewController?.view.addGestureRecognizer(panRecognizer)
        }
    }

    var isStarted = false

    // MARK: - Private properties.

    private var isFinished = false

    // MARK: - Private methods.

    @objc private func handleScreenEdgeGestureAction(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            isStarted = true
            viewController?.navigationController?.popViewController(animated: true)
        case .changed:
            guard let recognizerWidth = recognizer.view?.bounds.width else { return }
            let translation = recognizer.translation(in: recognizer.view)
            let relativeTranslation = translation.y / recognizerWidth
            let progress = max(0, min(1, relativeTranslation))
            isFinished = progress > 0.33
            update(progress)
        case .ended:
            isStarted = false
            guard isFinished else {
                cancel()
                return
            }
            finish()
        case .cancelled:
            isStarted = false
            cancel()
        default: return
        }
    }
}
