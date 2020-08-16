//
//  PlanCollectionViewCell.swift
//  AG_Test01
//
//  Created by Kohei Yaeo on 2020/08/16.
//  Copyright © 2020 Kohei Yaeo. All rights reserved.
//

import UIKit

class PlanCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    static let identifier = "PlanCollectionViewCell"
    static let aspectRatio: CGFloat = 4 / 3

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 25
    }

    static func nib() -> UINib {
        return UINib(nibName: "PlanCollectionViewCell", bundle: nil)
    }

}
