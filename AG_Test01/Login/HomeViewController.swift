import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        Utilities.styleFilledButton(startButton)
    }
    
}
