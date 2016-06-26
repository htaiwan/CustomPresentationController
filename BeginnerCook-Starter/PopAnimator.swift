//
//  PopAnimator.swift
//  BeginnerCook
//
//  Created by Chien-Tai Cheng on 6/26/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import UIKit

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    let duration = 1.0
    var presenting = true
    var originFrame = CGRect.zero

    var dismissCompletion: (()->())?

    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return duration
    }

    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView()!
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        // If you’re presenting, herbView is just the toView; otherwise it will be fetched from the context. For both presenting and dismissing, herbView will always be the view that you animate
        let herbView = presenting ? toView : transitionContext.viewForKey(UITransitionContextFromViewKey)!

        // detect the initial and final animation frames and then calculate the scale factor you need to apply on each axis as you animate between each view.
        let initialFrame = presenting ? originFrame : herbView.frame
        let finalFrame = presenting ? herbView.frame : originFrame
        let xScaleFactor = presenting ? initialFrame.width / finalFrame.width : finalFrame.width / initialFrame.width
        let yScaleFactor = presenting ? initialFrame.height / finalFrame.height : finalFrame.height / initialFrame.height

        //  set its scale and position so it exactly matches the size and location of the initial frame.
        let scaleTransform = CGAffineTransformMakeScale(xScaleFactor, yScaleFactor)
        if presenting {
            herbView.transform = scaleTransform
            herbView.center = CGPoint(
                x: CGRectGetMidX(initialFrame),
                y: CGRectGetMidY(initialFrame))
            herbView.clipsToBounds = true
        }

        // first add toView to the container
        containerView.addSubview(toView)
        // make sure the herbView is on top since that’s the only view you’re animating
        containerView.bringSubviewToFront(herbView)

        UIView.animateWithDuration(duration,
                                   delay:0.0,
                                   usingSpringWithDamping: 0.4,
                                   initialSpringVelocity: 0.0,
                                   options: [],
                                   animations: {
                                    herbView.transform = self.presenting ? CGAffineTransformIdentity : scaleTransform
                                    herbView.center = CGPoint(x: CGRectGetMidX(finalFrame), y: CGRectGetMidY(finalFrame))
            }, completion:{_ in
                if !self.presenting {
                    // executes dismissCompletion once the dismiss animation has finished
                    self.dismissCompletion?()
                }
                // called completeTransition() to hand things back to UIKit
                transitionContext.completeTransition(true)
        })

    }

}
