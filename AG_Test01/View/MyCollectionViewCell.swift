import UIKit

class MyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    static let identifier = "MyCollectionViewCell"
    static let aspectRatio: CGFloat = 4 / 3
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 10
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "MyCollectionViewCell", bundle: nil)
    }

}
