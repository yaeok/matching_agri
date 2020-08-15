//
//  MatterDetailViewController.swift
//  AG_Test01
//
//  Created by Kohei Yaeo on 2020/08/09.
//  Copyright © 2020 Kohei Yaeo. All rights reserved.
//

import UIKit
import EventKit
import Firebase

class MatterDetailViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    var receiveId: String = ""
    var receiveTitle: String = ""
    var receiveAddress: String = ""
    var receiveDate: String = ""
    var receiveStartTime: String = ""
    var receiveTime:String = ""
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
        let dialog = UIAlertController(title: "手伝い確認", message: "手伝い予定に入れますか？", preferredStyle: .actionSheet)
        
        dialog.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(dialog, animated: true, completion: nil)
          dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            self.db.collection("matter_Info").document(self.receiveId).delete()
            
            self.db.collection("swift_users").document(self.useId).collection("matter_Info").addDocument(data: [
                "matter_Title" : self.receiveTitle,
                "matter_Address" : self.receiveAddress,
                "matter_Date" : self.receiveDate,
                "matter_Start_Time" : self.receiveStartTime,
                "matter_Time" : self.receiveTime,
                "matter_Money" : self.receiveMoney,
                "matter_Content" : self.receiveContent
            ])
            let startTime = self.receiveDate + " " + self.receiveStartTime
            
            self.check_permission(start_date: self.dateFromString(string: startTime, format: "yyyy/MM/dd HH"), event_name: self.receiveTitle)
            
            self.dismiss(animated: true, completion: nil)
          }))
    }
    func dateFromString(string: String, format: String) -> Date {
        let formatter: DateFormatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = format
        return formatter.date(from: string)!
    }

    func check_permission(start_date: Date, event_name: String) {
        let event_store = EKEventStore()
        switch EKEventStore.authorizationStatus(for: .event) {
        
        case .notDetermined:
            event_store.requestAccess(to: .event) { (status, error) in
                if status {
                    self.innsert_event(store: event_store, start_date: start_date, event_name: event_name)

                } else {
                    print(error?.localizedDescription)
                }
            }
        case .restricted:
            print("restricted")
        case .denied:
            print("denied")
        case .authorized:
            self.innsert_event(store: event_store, start_date: start_date, event_name: event_name)
        @unknown default:
            print("Unknown")
        }
    }
    
    func innsert_event(store: EKEventStore, start_date: Date, event_name: String) {
        let elapsedTime = Int(self.receiveTime)! * 3600
        let calendars = store.calendars(for: .event)
        for calendar in calendars {
            if calendar.title == "Calendar" {
                let event = EKEvent(eventStore: store)
                event.calendar = calendar
                event.startDate = start_date
                event.title = event_name
                event.endDate = event.startDate.addingTimeInterval(TimeInterval(elapsedTime))
                event.recurrenceRules = [EKRecurrenceRule(recurrenceWith: .daily, interval: 1, end: nil)]
                let reminder1 = EKAlarm(relativeOffset: -600)
                let reminder2 = EKAlarm(relativeOffset: -1800)
                event.alarms = [reminder1, reminder2]
                
                do {
                    try store.save(event, span: .thisEvent)
                    print("event insert")
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
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
        cell.timeLabel.text = "\(receiveStartTime)〜(\(receiveTime)h)"
        cell.addressLabel.text = receiveAddress
        cell.moneyLabel.text = "\(receiveMoney)円 / 1h"
        cell.contentLabel.text = receiveContent
            
        cell.backgroundColor = UIColor.init(red: 0/255, green: 250/255, blue: 154/255, alpha: 0.4)
            
        return cell
    }
}
