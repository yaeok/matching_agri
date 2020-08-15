//
//  HomeViewController.swift
//  AG_Test01
//
//  Created by Kohei Yaeo on 2020/08/15.
//  Copyright © 2020 Kohei Yaeo. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        Utilities.styleFilledButton(startButton)
    }
    
}
