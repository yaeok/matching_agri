//
//  AccountViewController.swift
//  AG_Test01
//
//  Created by Kohei Yaeo on 2020/08/09.
//  Copyright © 2020 Kohei Yaeo. All rights reserved.
//

import UIKit
import FirebaseAuth

class AccountViewController: UIViewController {
    
    @IBOutlet weak var settingTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingTableView.delegate = self
        settingTableView.dataSource = self

        var handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            let user = Auth.auth().currentUser
            if let user = user {
                let uid = user.uid
                let email = user.email
                print(uid)
            }
        }
    }
    
}
extension AccountViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0: return 2
        case 1: return 3
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath) as! SettingTableViewCell
        
        switch indexPath.section {
        case 0: cell.backgroundColor = .red
        case 1: cell.backgroundColor = .blue
        default: break
        }
        return cell
    }
    
    
}
