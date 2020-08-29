import UIKit
import FirebaseAuth

class SettingTableViewController: UITableViewController {

    @IBOutlet weak var versionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = Auth.auth().currentUser
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        header.backgroundColor = UIColor.blue.withAlphaComponent(0.1)
        tableView.tableHeaderView = header
        
        let image = UIImageView(frame: header.bounds)
        image.frame = CGRect(x: 20, y: 10, width: 80, height: 80)
        image.image = UIImage(named: "icon_155360_256")
        image.backgroundColor = .white
        image.layer.cornerRadius = 10
        header.addSubview(image)
        
        let emailLabel = UILabel(frame: header.bounds)
        emailLabel.textColor = UIColor.lightGray
        emailLabel.text = user!.email
        emailLabel.frame = CGRect(x: 120, y: 60, width: self.view.frame.size.width * 3/5, height: 30)
        emailLabel.font.withSize(6)
        header.addSubview(emailLabel)
        
        let nameLabel = UILabel(frame: header.bounds)
        nameLabel.text = user!.uid
        nameLabel.frame = CGRect(x: 120, y: 30, width: self.view.frame.size.width * 3/5, height: 30)
        header.addSubview(nameLabel)
        
        if let version: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String {
            versionLabel.text = version
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
          return 3
        case 1:
          return 1
        default:
          return 0
        }
    }

}
