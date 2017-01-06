//
//  DetailViewController.swift
//  CustomTransition
//
//  Created by Dongbing Hou on 05/01/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var imgView: UIImageView!
    
    var percentTransition: UIPercentDrivenInteractiveTransition!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.cyan
        imgView = UIImageView(image: UIImage(named: "Ulysses.jpg"))
        view.addSubview(imgView)
        imgView.center = view.center
        
        let pan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgePanGesture(_:)))
        pan.edges = .left
        view.addGestureRecognizer(pan)
        
    }
    
    func screenEdgePanGesture(_ pan: UIScreenEdgePanGestureRecognizer) {
        var percent = pan.translation(in: view).x / view.bounds.width
        percent = min(max(0.0, percent), 1.0) // 0~1
        
        switch pan.state {
        case .began:
            percentTransition = UIPercentDrivenInteractiveTransition()
            let _ = navigationController?.popViewController(animated: true)
        case .changed:
            percentTransition.update(percent)
        case .ended:
            percent > 0.5 ? percentTransition.finish() : percentTransition.cancel()
            percentTransition = nil
        default:
            break
        }
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension DetailViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return MagicMoveTransition(type: operation == .push ? .push : .pop)
    }
}
