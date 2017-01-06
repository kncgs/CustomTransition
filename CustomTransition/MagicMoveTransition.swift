//
//  MagicMoveTransition.swift
//  CustomTransition
//
//  Created by Dongbing Hou on 05/01/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

enum TransitionType {
    case push, pop
}

class MagicMoveTransition: NSObject {
    
    fileprivate var type: TransitionType
    
    init(type: TransitionType) {
        self.type = type
    }
    
    fileprivate let transitionDuration:         TimeInterval = 0.3
    fileprivate let delay:                      TimeInterval = 0
    fileprivate let damping:                    CGFloat = 0.8
    fileprivate let velocity:                   CGFloat = 8
}

extension MagicMoveTransition: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch type {
        case .push:
            pushAnimator(context: transitionContext)
        case .pop:
            popAnimator(context: transitionContext)
        }
    }
}

extension MagicMoveTransition {
    
    func pushAnimator(context: UIViewControllerContextTransitioning) {
        let fromVC = context.viewController(forKey: .from) as! CollectionViewController
        let toVC = context.viewController(forKey: .to) as! DetailViewController
        let containerView = context.containerView
        
        // 1. 找到当前选中的cell
        let cell = fromVC.collectionView?.cellForItem(at: fromVC.selectedIndexPath) as! CollectionViewCell
        
        // 2. 对当前选中的cell截屏
        let snapshotView = cell.imgView.snapshotView(afterScreenUpdates: false)!
        // 将rect由rect所在视图转换到目标视图中，并返回在目标视图中的frame
        snapshotView.frame = cell.imgView.convert(cell.imgView.bounds, to: containerView)
        
        // 3. 设置动画前视图状态
        cell.imgView.isHidden = true
        
        toVC.view.alpha = 0
        toVC.imgView.isHidden = true
        
        // 4.
        containerView.addSubview(toVC.view)
        containerView.addSubview(snapshotView)
        
        // 5.
        /**
         * @param usingSpringWithDamping 值越小弹簧效果越明显
         * @param initialSpringVelocity 初始速度，值越大动画越快
         */
        UIView.animate(withDuration: transitionDuration, delay: delay, usingSpringWithDamping: damping, initialSpringVelocity: velocity, options: .curveEaseInOut, animations: {
            snapshotView.frame = toVC.imgView.convert(toVC.imgView.bounds, to: containerView)
            toVC.view.alpha = 1
            
        }) { (_) in
            snapshotView.isHidden = true
            toVC.imgView.isHidden = false
            context.completeTransition(true)
        } 
    }
    
    func popAnimator(context: UIViewControllerContextTransitioning) {
        let fromVC = context.viewController(forKey: .from) as! DetailViewController
        let toVC = context.viewController(forKey: .to) as! CollectionViewController
        let containerView = context.containerView
        
        let cell = toVC.collectionView?.cellForItem(at: toVC.selectedIndexPath) as! CollectionViewCell
        let tempView = containerView.subviews.last!
        
        cell.imgView.isHidden = true
        fromVC.imgView.isHidden = true
        
        tempView.isHidden = false
        
        containerView.insertSubview(toVC.view, at: 0)
        
        UIView.animate(withDuration: transitionDuration, delay: delay, usingSpringWithDamping: damping, initialSpringVelocity: velocity, options: .curveEaseIn, animations: {
            tempView.frame = cell.imgView.convert(cell.imgView.bounds, to: containerView)
            fromVC.view.alpha = 0
        }) { (_) in
            let isCancelled = context.transitionWasCancelled
            context.completeTransition(!isCancelled)
            if isCancelled {
                tempView.isHidden = true
                fromVC.imgView.isHidden = false
            } else {
                cell.imgView.isHidden = false
                tempView.removeFromSuperview()
            }
        }
    }
}
