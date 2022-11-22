// PushTransitionAnimator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Forward move animation.
final class PushTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    // MARK: - Private Constants.

    private enum Constants {
        static let screenRotationAxisXDouble = 1.6
    }

    // MARK: - Public methods.

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.5
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let source = transitionContext.viewController(forKey: .from),
            let destination = transitionContext.viewController(forKey: .to)
        else { return }
        let destinationWidth = destination.view.frame.width
        transitionContext.containerView.addSubview(destination.view)
        destination.view.frame = source.view.frame
        let rotation = CGAffineTransform(rotationAngle: .pi / -2)
        let translation = CGAffineTransform(
            translationX: destinationWidth * Constants.screenRotationAxisXDouble,
            y: destinationWidth / -2
        )
        destination.view.transform = rotation.concatenating(translation)

        UIView.animateKeyframes(
            withDuration: 0.5,
            delay: 0,
            options: .calculationModePaced
        ) {
            UIView.addKeyframe(
                withRelativeStartTime: 0.2,
                relativeDuration: 0.4
            ) {
                source.view.transform = CGAffineTransform(translationX: destinationWidth, y: 0)
            }
            UIView.addKeyframe(
                withRelativeStartTime: 0.6,
                relativeDuration: 0.4
            ) {
                destination.view.transform = .identity
            }
        } completion: { finished in
            if finished, !transitionContext.transitionWasCancelled {
                source.view.transform = .identity
            }
            transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
        }
    }
}
