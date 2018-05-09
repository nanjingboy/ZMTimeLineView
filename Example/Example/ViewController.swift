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
        timeLineView.reloadData { (height) in
            timeLineView.snp.remakeConstraints({ (make) in
                make.edges.equalTo(scrollView)
                make.width.equalTo(scrollView)
                make.height.equalTo(height)
            })
        }
    }

    func numberOfTimeLineRecordCount(_ timeLineView: TimeLineView) -> Int {
        return 20
    }

    func timeLineView(_ timeLineView: TimeLineView, isHighlight index: Int) -> Bool {
        return index == 0
    }

    func timeLineView(_ timeLineView: TimeLineView, contentViewHeight contentView: UIView, index: Int) -> CGFloat {
        return 46
    }
    
    func timeLineView(_ timeLineView: TimeLineView, contentView index: Int) -> UIView {
        let view = TimeLineContentView()
        view.titleLabel.text = "Test Title"
        view.contentLabel.text = "Test Content"
        view.dateTimeLabel.text = "2018-05-01 18:02"
        if index == 0 {
            view.titleLabel.textColor = TimeLineColors.highlightColor
            view.contentLabel.textColor = TimeLineColors.highlightColor
            view.dateTimeLabel.textColor = TimeLineColors.highlightColor
        } else {
            view.titleLabel.textColor = TimeLineColors.defaultColor
            view.contentLabel.textColor = TimeLineColors.defaultColor
            view.dateTimeLabel.textColor = TimeLineColors.defaultColor
        }
        return view
    }
}
