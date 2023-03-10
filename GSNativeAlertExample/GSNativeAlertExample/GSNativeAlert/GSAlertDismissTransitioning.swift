//
//  EFAlertDismissTransitioning.swift
//  CustomAlert
//
//  Created by Admin on 21/10/22.
//

import Foundation
import UIKit

class GSAlertDismissTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from), let toVC = transitionContext.viewController(forKey: .to) else { return }
        let dimmerView = transitionContext.containerView.subviews.filter { $0.tag == 2314234423 }.first

        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
            toVC.view.transform = .identity
            fromVC.view.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            
            fromVC.view.alpha = 0
            dimmerView?.alpha = 0

        } completion: { finish in
            transitionContext.completeTransition(finish)
        }

    }
}
