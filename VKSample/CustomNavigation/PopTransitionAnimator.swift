// PopTransitionAnimator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Backward move animation.
final class PopTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    // MARK: - Public methods.

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.5
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let source = transitionContext.viewController(forKey: .from),
            let destination = transitionContext.viewController(forKey: .to)
        else { return }
        let sourceWidth = source.view.frame.width
        transitionContext.containerView.addSubview(destination.view)
        transitionContext.containerView.sendSubviewToBack(destination.view)
        destination.view.frame = source.view.frame
        destination.view.transform = CGAffineTransform(translationX: sourceWidth, y: 0)

        UIView.animateKeyframes(
            withDuration: 0.5,
            delay: 0,
            options: .calculationModePaced
        ) {
            UIView.addKeyframe(
                withRelativeStartTime: 0,
                relativeDuration: 0.5
            ) {
                let translation = CGAffineTransform(
                    translationX: sourceWidth * 1.6,
                    y: sourceWidth / -2
                )
                let rotation = CGAffineTransform(rotationAngle: .pi / -2)
                source.view.transform = rotation.concatenating(translation)
            }
            UIView.addKeyframe(
                withRelativeStartTime: 0,
                relativeDuration: 0.5
            ) {
                destination.view.transform = .identity
            }
        } completion: { finished in
            if finished, !transitionContext.transitionWasCancelled {
                source.removeFromParent()
            } else if transitionContext.transitionWasCancelled {
                destination.view.transform = .identity
            }
            transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
        }
    }
}
