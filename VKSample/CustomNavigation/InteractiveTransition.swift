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
                action: #selector(handleScreenEdgeGesture)
            )
            panRecognizer.edges = [.left]
            viewController?.view.addGestureRecognizer(panRecognizer)
        }
    }

    var hasStarted: Bool = false

    // MARK: - Private properties.

    private var shouldFinished: Bool = false

    // MARK: - Private methods.

    @objc private func handleScreenEdgeGesture(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            hasStarted = true
            viewController?.navigationController?.popViewController(animated: true)
        case .changed:
            guard let recognizerWidth = recognizer.view?.bounds.width else { return }
            let translation = recognizer.translation(in: recognizer.view)
            let relativeTranslation = translation.y / recognizerWidth
            let progress = max(0, min(1, relativeTranslation))
            shouldFinished = progress > 0.33
            update(progress)
        case .ended:
            hasStarted = false
            guard shouldFinished else {
                cancel()
                return
            }
            finish()
        case .cancelled:
            hasStarted = false
            cancel()
        default: return
        }
    }
}
