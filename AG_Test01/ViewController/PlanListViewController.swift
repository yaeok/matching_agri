//
//  PlanListViewController.swift
//  AG_Test01
//
//  Created by Kohei Yaeo on 2020/08/09.
//  Copyright © 2020 Kohei Yaeo. All rights reserved.
//

import UIKit
import Firebase

class PlanListViewController: UIViewController {
    
    var postId: String = ""
    var postTitle: String = ""
    var postAddress: String = ""
    var postDate: String = ""
    var postMoney: String = ""
    var postContent: String = ""
    
    let db = Firestore.firestore()
    @IBOutlet weak var tableView: UITableView!
    var planList = [PlanModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db.collection("swift_users").document("2tVlFv0kXSev9DU6cd8g").collection("matter_Info").getDocuments{ (snaps, error) in
            if error != nil {
                
            } else {
                guard let snaps = snaps else {
                    return
                }
                
                for document in snaps.documents {
                    let id = document.documentID
                    let planObject = document.data() as [String: AnyObject]
                    let title = planObject["matter_Title"]
                    let address = planObject["matter_Address"]
                    let date = planObject["matter_Date"]
                    let money = planObject["matter_Money"]
                    let content = planObject["matter_Content"]
                    
                    let plans = PlanModel(Id: id, Title: title as? String, Date: date as? String, Address: address as? String, Money: money as? String, Content: content as? String)
                    self.planList.append(plans)
                }
            }
            self.tableView.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
extension PlanListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PlanTableViewCell
        
        let plan: PlanModel
        plan = planList[indexPath.row]
        cell.titleLabel.text = plan.Title
        cell.dateLabel.text = plan.Address
        cell.addressLabel.text = plan.Date
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            let plan: PlanModel
            plan = planList[indexPath.row]
            postId = plan.Id!
            postTitle = plan.Title!
            postAddress = plan.Address!
            postDate = plan.Date!
            postMoney = plan.Money!
            postContent = plan.Content!
        }
        performSegue(withIdentifier: "Next", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Next" {
            let vc = segue.destination as! PlanDetailViewController
            vc.receiveId = postId
            vc.receiveTitle = postTitle
            vc.receiveAddress = postAddress
            vc.receiveDate = postDate
            vc.receiveMoney = postMoney
            vc.receiveContent = postContent
        }
    }
}
