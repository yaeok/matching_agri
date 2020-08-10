//
//  Utilities.swift
//  AG_Test01
//
//  Created by Kohei Yaeo on 2020/08/09.
//  Copyright © 2020 Kohei Yaeo. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    static func styleHelpedButton(_ button:UIButton) {
        button.backgroundColor = UIColor.init(red: 154/255, green: 205/255, blue: 50/255, alpha: 1)
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.black
    }
    
    static func styleSupportButton(_ button:UIButton) {
        button.backgroundColor = UIColor.init(red: 153/255, green: 255/255, blue: 153/255, alpha: 1)
        button.layer.cornerRadius = 20.0
        button.tintColor = UIColor.black
    }
    
    static func styleHelpLabel(_ label:UILabel) {
        label.backgroundColor = UIColor.init(red: 153/255, green: 255/255, blue: 153/255, alpha: 0.3)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
    }
    
}
