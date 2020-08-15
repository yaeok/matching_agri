//
//  PlanDetailViewController.swift
//  AG_Test01
//
//  Created by Kohei Yaeo on 2020/08/09.
//  Copyright © 2020 Kohei Yaeo. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseFirestore

class PlanDetailViewController: UIViewController {

    let db = Firestore.firestore()
    
    var receiveId: String = ""
    var receiveTitle: String = ""
    var receiveAddress: String = ""
    var receiveDate: String = ""
    var receiveMoney: String = ""
    var receiveContent: String = ""
    
    @IBOutlet weak var supportButton: UIButton!
    let useId = "2tVlFv0kXSev9DU6cd8g"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = receiveTitle
        dateLabel.text = receiveDate
        addressLabel.text = receiveAddress
        moneyLabel.text = receiveMoney
        contentLabel.text = receiveContent
        
        Utilities.styleHelpLabel(titleLabel)
        Utilities.styleHelpLabel(dateLabel)
        Utilities.styleHelpLabel(addressLabel)
        Utilities.styleHelpLabel(moneyLabel)
        Utilities.styleHelpLabel(contentLabel)
        Utilities.styleSupportButton(supportButton)
        
    }
    @IBAction func tappedButton(_ sender: Any) {
        db.collection("swift_users").document(useId).collection("matter_Info").document(receiveId).delete()
        
        db.collection("swift_users").document(useId).collection("matter_history").addDocument(data: [
            "history_Title" : receiveTitle,
            "history_Date" : receiveDate,
            "history_Address" : receiveAddress,
            "history_Money" : receiveMoney,
            "history_Content" : receiveContent
        ])
    }
}
