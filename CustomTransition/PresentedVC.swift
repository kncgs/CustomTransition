//
//  PresentedVC.swift
//  CustomTransition
//
//  Created by Dongbing Hou on 06/01/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class PresentedVC: UIViewController {
    
    private lazy var presentingVC: PresentingVC = PresentingVC()
    private lazy var preseatationController: PresentationController = PresentationController(presentedViewController: self.presentingVC, presenting: self)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presentingVC.transitioningDelegate = preseatationController
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func presentBtnClicked() {
        present(presentingVC, animated: true, completion: nil)
    }
}
