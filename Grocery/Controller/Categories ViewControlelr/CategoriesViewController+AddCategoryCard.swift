//
//  CategoriesViewController+AddCategoryCard.swift
//  Grocery
//
//  Created by Takasur Azeem on 05/01/2020.
//  Copyright © 2020 Takasur Azeem. All rights reserved.
//

import UIKit

extension CategoriesViewController {
    /**
     For : how would you go about adding scrollable content inside of the "card view". is it possible to move the y position of the card as the content scrolls?
     extension CardViewController: UIGestureRecognizerDelegate {
     func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
     let offest = scrollView.contentOffset
     
     let v = (gestureRecognizer as! UIPanGestureRecognizer).velocity(in: nil)
     return v.y > abs(v.x) && offest.y <= 0
     }
     
     func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
     
     return true
     }
     }
     */

    func setupCard() {
        visualEffectView = UIVisualEffectView(frame: self.view.frame)
        self.view.addSubview(visualEffectView)
        
        cardViewController = AddCategoryViewController(nibName: "CardViewController", bundle: nil)
        self.addChild(cardViewController)
        self.view.addSubview(cardViewController.view)
        
        cardViewController.view.frame = .init(x: 0, y: self.view.frame.height, width: self.view.bounds.width, height: cardHeight)
        
        cardViewController.view.clipsToBounds = true
        
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(CategoriesViewController.handleCardPanGgesture(recognizer:)))
        
        cardViewController.handleArea.addGestureRecognizer(panGestureRecognizer)
    }
    
    func animateTransitionIfNeeded(state: CardState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) { [weak self] in
                guard let self = self else {return}
                switch state {
                case .expanded:
                    self.cardViewController.view.frame.origin.y = self.view.frame.height - self.cardHeight
                case .collapsed:
                    self.cardViewController.view.frame.origin.y = self.view.frame.height
                }
            }
            
            frameAnimator.addCompletion { [weak self] _ in
                guard let self = self else {return}
                self.cardVisible = !self.cardVisible
                self.runningAnimations.removeAll()
            }
            
            frameAnimator.startAnimation()
            runningAnimations.append(frameAnimator)
            
            let cornerRadiusAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear) { [weak self] in
                guard let self = self else {return}
                switch state {
                case .expanded:
                    self.cardViewController.view.layer.cornerRadius = 12
                case .collapsed:
                    self.cardViewController.view.layer.cornerRadius = 0
                }
            }
            cornerRadiusAnimator.startAnimation()
            runningAnimations.append(cornerRadiusAnimator)
            
            let blurAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) { [weak self] in
                guard let self = self else {return}
                switch state {
                case .expanded:
                    self.visualEffectView.effect = UIBlurEffect(style: .dark)
                case .collapsed:
                    self.visualEffectView.effect = nil
                }
            }
            blurAnimator.startAnimation()
            runningAnimations.append(blurAnimator)
        }
    }
    
    func startInteractiveTransition(state: CardState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            animateTransitionIfNeeded(state: state, duration: duration)
        }
        for animator in runningAnimations {
            animator.pauseAnimation()
            animationProgressWhenInterupted = animator.fractionComplete
        }
    }
    
    func updateInteractiveTransition(fractionCompleted: CGFloat) {
        for animator in runningAnimations {
            animator.fractionComplete = fractionCompleted + animationProgressWhenInterupted
        }
    }
    
    func continueInteractiveTransition() {
        for animator in runningAnimations {
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }
    @objc func handleCardPanGgesture(recognizer: UIPanGestureRecognizer) {
        
        switch recognizer.state {
        case .began:
            // start transition
            startInteractiveTransition(state: nextState, duration: 0.9)
        case .changed:
            // update transition
            let translation = recognizer.translation(in: self.cardViewController.handleArea)
            var fractionComplete = translation.y / cardHeight
            fractionComplete = cardVisible ? fractionComplete : -fractionComplete
            updateInteractiveTransition(fractionCompleted: fractionComplete)
        case .ended:
            // coninue transition
            continueInteractiveTransition()
            // IMPORTANT!!!
            visualEffectView.isUserInteractionEnabled = false
        default:
            break
        }
    }
}
