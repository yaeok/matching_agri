//
//  MatterListViewController.swift
//  AG_Test01
//
//  Created by Kohei Yaeo on 2020/08/09.
//  Copyright © 2020 Kohei Yaeo. All rights reserved.
//

import UIKit
import Firebase

class MatterListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var postId: String = ""
    var postTitle: String = ""
    var postAddress: String = ""
    var postDate: String = ""
    var postMoney: String = ""
    var postContent: String = ""
        
    let db = Firestore.firestore()
    var matterList = [MatterModel]()
    
    private var cellSize: CGSize {
        let width = collectionView.bounds.width * 0.40
        let height = width * MyCollectionViewCell.aspectRatio * 0.7
        return CGSize(width: width, height: height)
    }
            
    override func viewDidLoad() {
        super.viewDidLoad()
            
        collectionView.register(MyCollectionViewCell.nib(), forCellWithReuseIdentifier: MyCollectionViewCell.identifier)
            
        collectionView.delegate = self
        collectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: 20, left: 27, bottom: 20, right: 27)
        collectionView.collectionViewLayout = layout
            
        db.collection("matter_Info").order(by: "matter_Date").getDocuments{ (snaps, error) in
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
                        
                    let matter = MatterModel(Id: id, Title: title as? String, Date: date as? String, Address: address as? String, Money: money as? String, Content: content as? String)
                    self.matterList.append(matter)
                }
            }
            self.collectionView.reloadData()
        }
    }
}

extension MatterListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if indexPath.section == 0{
            let matter: MatterModel
            matter = matterList[indexPath.row]
            postId = matter.Id!
            postTitle = matter.Title!
            postAddress = matter.Address!
            postDate = matter.Date!
            postMoney = matter.Money!
            postContent = matter.Content!
        }
        performSegue(withIdentifier: "Next", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Next" {
            let vc = segue.destination as! MatterDetailViewController
            vc.receiveId = postId
            vc.receiveTitle = postTitle
            vc.receiveAddress = postAddress
            vc.receiveDate = postDate
            vc.receiveMoney = postMoney
            vc.receiveContent = postContent
        }
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return matterList.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.identifier, for: indexPath) as! MyCollectionViewCell
            
        let matter: MatterModel
        matter = matterList[indexPath.row]
        cell.titleLabel.text = matter.Title
        cell.dateLabel.text = matter.Date
        cell.addressLabel.text = matter.Address
            
        cell.backgroundColor = UIColor.init(red: 153/255, green: 255/255, blue: 153/255, alpha: 0.3)
            
        return cell
    }
}
