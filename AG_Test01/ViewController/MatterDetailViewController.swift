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
        let dialog = UIAlertController(title: "Dialog Title", message: "Message is here", preferredStyle: .actionSheet)
        
        dialog.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(dialog, animated: true, completion: nil)
          dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            self.db.collection("matter_Info").document(self.receiveId).delete()
            
            self.db.collection("swift_users").document(self.useId).collection("matter_Info").addDocument(data: [
                "matter_Title" : self.receiveTitle,
                "matter_Address" : self.receiveAddress,
                "matter_Date" : self.receiveDate,
                "matter_Money" : self.receiveMoney,
                "matter_Content" : self.receiveContent
            ])
            
            self.dismiss(animated: true, completion: nil)
          }))
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
