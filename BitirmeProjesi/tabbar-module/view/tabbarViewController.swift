//
//  tabbarViewController.swift
//  BitirmeProjesi
//
//  Created by Cagla Efendioglu on 1.11.2022.
//

import UIKit

class tabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationController?.navigationItem.hidesBackButton = true
        self.tabBarController?.navigationController?.navigationItem.hidesBackButton = true
    }

}
