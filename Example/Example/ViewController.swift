import UIKit
import SnapKit
import ZMTimeLineView

class ViewController: UIViewController, TimeLineViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title = "TimeLineView Demo"

        let scrollView = UIScrollView()
        scrollView.scrollsToTop = false
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        let timeLineView = TimeLineView()
        timeLineView.dataSource = self
        self.view.addSubview(timeLineView)
        scrollView.addSubview(timeLineView)
        timeLineView.snp.makeConstraints { (make) in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
        timeLineView.reloadData()
    }

    func numberOfTimeLineRecordCount(_ timeLineView: TimeLineView) -> Int {
        return 10
    }

    func timeLineView(_ timeLineView: TimeLineView, widthForRowAt index: Int) -> CGFloat {
        return UIScreen.main.bounds.width
    }

    func timeLineView(_ timeLineView: TimeLineView, title index: Int) -> String {
        return "Test Title"
    }

    func timeLineView(_ timeLineView: TimeLineView, content index: Int) -> String {
        if index % 2 == 0 {
            return "Test Content"
        }
        return "Test Content1,Test Content2,Test Content3,Test Content4,Test Content5,Test Content6"
    }

    func timeLineView(_ timeLineView: TimeLineView, dateTime index: Int) -> String {
        return "2016-12-12 12:12"
    }

    func timeLineView(_ timeLineView: TimeLineView, isHighlight index: Int) -> Bool {
        return index == 0
    }
}
