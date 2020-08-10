//
//  HistoryListViewController.swift
//  AG_Test01
//
//  Created by Kohei Yaeo on 2020/08/09.
//  Copyright © 2020 Kohei Yaeo. All rights reserved.
//

import UIKit
import Firebase

class HistoryListViewController: UIViewController {
    
    let db = Firestore.firestore()
    @IBOutlet weak var tableView: UITableView!
    var hisitoryList = [HistoryModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        db.collection("swift_users").document("2tVlFv0kXSev9DU6cd8g").collection("matter_history").getDocuments{ (snaps, error) in
            if error != nil {
                
            } else {
                guard let snaps = snaps else {
                    return
                }
                
                for document in snaps.documents {
                    let planObject = document.data() as [String: AnyObject]
                    let title = planObject["history_Title"]
                    let adress = planObject["history_Address"]
                    let date = planObject["history_Date"]
                        
                    let plans = HistoryModel(Title: title as? String, Date: adress as? String, Address: date as? String)
                    self.hisitoryList.append(plans)
                }
            }
            self.tableView.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
extension HistoryListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hisitoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HistoryTableViewCell
        
        let plan: HistoryModel
        plan = hisitoryList[indexPath.row]
        cell.titleLabel.text = plan.Title
        cell.dateLabel.text = plan.Address
        cell.addressLabel.text = plan.Date
        
        return cell
    }
}
