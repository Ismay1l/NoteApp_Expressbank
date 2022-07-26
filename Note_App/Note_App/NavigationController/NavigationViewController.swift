//
//  NavigationViewController.swift
//  Note_App
//
//  Created by Ismayil Ismayilov on 27.07.22.
//

import UIKit

class NavigationViewController: UINavigationController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc = HomeViewController()
        self.viewControllers = [vc]
        
        interactivePopGestureRecognizer?.isEnabled = true
        interactivePopGestureRecognizer?.delegate = self
        
        navigationBar.prefersLargeTitles = true
        vc.navigationItem.title = "Notes"
    }
}
