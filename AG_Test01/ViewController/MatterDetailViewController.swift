//
//  MatterDetailViewController.swift
//  AG_Test01
//
//  Created by Kohei Yaeo on 2020/08/09.
//  Copyright © 2020 Kohei Yaeo. All rights reserved.
//

import UIKit
import Firebase

class MatterDetailViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    var receiveId: String = ""
    var receiveTitle: String = ""
    var receiveAddress: String = ""
    var receiveDate: String = ""
    var receiveMoney: String = ""
    var receiveContent: String = ""
    
    @IBOutlet weak var helpButton: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let useId = "2tVlFv0kXSev9DU6cd8g"
    
    private var cellSize: CGSize {
        let width = collectionView.bounds.width * 0.9
        let height = width * MatterCollectionViewCell.aspectRatio
        return CGSize(width: width, height: height)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(MatterCollectionViewCell.nib(), forCellWithReuseIdentifier: MatterCollectionViewCell.identifier)
            
        collectionView.delegate = self
        collectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: 125, left: 30, bottom: 20, right: 30)
        collectionView.collectionViewLayout = layout
        
        Utilities.styleHelpedButton(helpButton)
        
    }
    @IBAction func tappedButton(_ sender: Any) {
        db.collection("matter_Info").document(receiveId).delete()
        
        db.collection("swift_users").document(useId).collection("matter_Info").addDocument(data: [
            "matter_Title" : receiveTitle,
            "matter_Address" : receiveAddress,
            "matter_Date" : receiveDate,
            "matter_Money" : receiveMoney,
            "matter_Content" : receiveContent
        ])
        
        dismiss(animated: true, completion: nil)
    }
    
}


extension MatterDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MatterCollectionViewCell.identifier, for: indexPath) as! MatterCollectionViewCell
                    
        cell.titleLabel.text = receiveTitle
        cell.dateLabel.text = receiveDate
        cell.addressLabel.text = receiveAddress
        cell.moneyLabel.text = "\(receiveMoney)円 / 1h"
        cell.contentLabel.text = receiveContent
            
        cell.backgroundColor = UIColor.init(red: 0/255, green: 250/255, blue: 154/255, alpha: 0.4)
            
        return cell
    }
}
