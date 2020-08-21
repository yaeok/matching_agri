//
//  SettingTableViewController.swift
//  AG_Test01
//
//  Created by Kohei Yaeo on 2020/08/19.
//  Copyright © 2020 Kohei Yaeo. All rights reserved.
//

import UIKit
import FirebaseAuth

class SettingTableViewController: UITableViewController {

    @IBOutlet weak var versionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = Auth.auth().currentUser
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        header.backgroundColor = UIColor.blue.withAlphaComponent(0.1)
        tableView.tableHeaderView = header
        
        let image = UIImageView(frame: header.bounds)
        image.frame = CGRect(x: 20, y: 10, width: 80, height: 80)
        image.image = UIImage(named: "icon_155360_256")
        image.backgroundColor = .white
        image.layer.cornerRadius = 10
        header.addSubview(image)
        
        let emailLabel = UILabel(frame: header.bounds)
        emailLabel.textColor = UIColor.lightGray
        emailLabel.text = user!.email
        emailLabel.frame = CGRect(x: 120, y: 60, width: self.view.frame.size.width * 3/5, height: 30)
        emailLabel.font.withSize(6)
        header.addSubview(emailLabel)
        
        let nameLabel = UILabel(frame: header.bounds)
        nameLabel.text = user!.uid
        nameLabel.frame = CGRect(x: 120, y: 30, width: self.view.frame.size.width * 3/5, height: 30)
        header.addSubview(nameLabel)
        
        if let version: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String {
            versionLabel.text = version
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
          return 3
        case 1:
          return 1
        default:
          return 0
        }
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
