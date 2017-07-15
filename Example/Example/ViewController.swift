import UIKit
import SnapKit
import ZMTimeLineView

class ViewController: UIViewController, TimeLineViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "TimeLineView Demo"

        let timeLineView = TimeLineView()
        timeLineView.dataSource = self
        self.view.addSubview(timeLineView)
        timeLineView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }

    func numberOfTimeLineRecordCount(_ timeLineView: TimeLineView) -> Int {
        return 10
    }

    func timeLineView(_ timeLineView: TimeLineView, title indexPath: IndexPath) -> String {
        return "Test Title"
    }

    func timeLineView(_ timeLineView: TimeLineView, content indexPath: IndexPath) -> String {
        if indexPath.row % 2 == 0 {
            return "Test Content"
        }
        return "Test Content1,Test Content2,Test Content3,Test Content4,Test Content5,Test Content6"
    }

    func timeLineView(_ timeLineView: TimeLineView, dateTime indexPath: IndexPath) -> String {
        return "2016-12-12 12:12"
    }

    func timeLineView(_ timeLineView: TimeLineView, isHighlight indexPath: IndexPath) -> Bool {
        return indexPath.row == 0
    }
}
