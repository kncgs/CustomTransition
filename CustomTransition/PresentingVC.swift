//
//  PresentingVC.swift
//  CustomTransition
//
//  Created by Dongbing Hou on 06/01/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class PresentingVC: UIViewController {

    let ScreentW = UIScreen.main.bounds.width
    let ScreentH = UIScreen.main.bounds.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.orange
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        updatePreferredContentSizeWithTraitCollection(newCollection)
    }
    func updatePreferredContentSizeWithTraitCollection(_ traitCollection: UITraitCollection) {
        preferredContentSize = CGSize(width: ScreentW, height: ScreentH * 0.9)
    }

}
