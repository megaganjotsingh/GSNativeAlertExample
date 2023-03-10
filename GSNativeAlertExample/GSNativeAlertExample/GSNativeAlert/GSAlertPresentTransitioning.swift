//
//  EFAlertPresentTransitioning.swift
//  CustomAlert
//
//  Created by Admin on 21/10/22.
//

import Foundation
import UIKit

class GSAlertPresentTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    var originFrame = UIScreen.main.bounds
    let dimmerView = UIView()

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toVC = transitionContext.viewController(forKey: .to) else { return }
        dimmerView.frame = originFrame
        dimmerView.tag = 2314234423
        transitionContext.containerView.addSubview(dimmerView)
        transitionContext.containerView.addSubview(toVC.view)
        toVC.view.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        dimmerView.alpha = 0
        toVC.view.alpha = 0

        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) { [weak self] in
            self?.dimmerView.backgroundColor = UIColor.secondarySystemBackground.withAlphaComponent(0.4)
            self?.dimmerView.alpha = 1
            toVC.view.transform = .identity
            toVC.view.alpha = 1
        } completion: { finish in
            transitionContext.completeTransition(finish)
        }

    }
}
