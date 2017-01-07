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
        addDismissBtn()
    }
    func addDismissBtn() {
        let btn = UIButton()
        btn.setTitle("dismiss", for: .normal)
        btn.addTarget(self, action: #selector(dismissBtnClicked), for: .touchDown)
        view.addSubview(btn)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        btn.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 100).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    func dismissBtnClicked() {
        dismiss(animated: true, completion: nil)
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
