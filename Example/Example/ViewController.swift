import UIKit
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white

        let label = UILabel()
        label.text = "Hello World"
        label.textAlignment = NSTextAlignment.center
        self.view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
}