//
//  PlanDetailViewController.swift
//  AG_Test01
//
//  Created by Kohei Yaeo on 2020/08/09.
//  Copyright © 2020 Kohei Yaeo. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

class PlanDetailViewController: UIViewController {

    let db = Firestore.firestore()
    
    var receiveId: String = ""
    var receiveTitle: String = ""
    var receiveAddress: String = ""
    var receiveDate: String = ""
    var receiveStartTime: String = ""
    var receiveTime:String = ""
    var receiveMoney: String = ""
    var receiveContent: String = ""
    
    @IBOutlet weak var supportButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var cellSize: CGSize {
        let width = collectionView.bounds.width * 0.9
        let height = width * PlanCollectionViewCell.aspectRatio
        return CGSize(width: width, height: height)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(PlanCollectionViewCell.nib(), forCellWithReuseIdentifier: PlanCollectionViewCell.identifier)
            
        collectionView.delegate = self
        collectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: 20, left: 27, bottom: 20, right: 27)
        collectionView.collectionViewLayout = layout

        Utilities.styleSupportButton(supportButton)
        
    }
    @IBAction func tappedButton(_ sender: Any) {
        let user = Auth.auth().currentUser
        db.collection("swift_users").document(user!.uid).collection("matter_Info").document(receiveId).delete()
        
        db.collection("swift_users").document(user!.uid).collection("matter_history").addDocument(data: [
            "history_Title" : receiveTitle,
            "history_Date" : receiveDate,
            "history_Address" : receiveAddress,
            "history_Start_Time" : receiveStartTime,
            "history_Time" : receiveTime,
            "history_Money" : receiveMoney,
            "history_Content" : receiveContent
        ])
    }
}

extension PlanDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlanCollectionViewCell.identifier, for: indexPath) as! PlanCollectionViewCell
                    
        cell.titleLabel.text = receiveTitle
        cell.dateLabel.text = receiveDate
        cell.timeLabel.text = "\(receiveStartTime)〜(\(receiveTime)h)"
        cell.addressLabel.text = receiveAddress
        cell.moneyLabel.text = "\(receiveMoney)円 / 1h"
        cell.contentLabel.text = receiveContent
            
        cell.backgroundColor = UIColor.init(red: 0/255, green: 250/255, blue: 154/255, alpha: 0.4)
            
        return cell
    }
}
