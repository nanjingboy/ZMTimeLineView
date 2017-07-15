import UIKit
import SnapKit

open class TimeLineView: UIView, UITableViewDataSource, UITableViewDelegate {

    fileprivate let tableView = UITableView()

    open var dataSource: TimeLineViewDataSource?

    open override var frame: CGRect {
        didSet {
            self.tableView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        }
    }

    open var padding: UIEdgeInsets = UIEdgeInsets(top: 10, left: 18, bottom: 10, right: 33) {
        didSet {
            self.tableView.reloadData()
        }
    }

    open var titleFont: UIFont = UIFont.systemFont(ofSize: 12) {
        didSet {
            self.tableView.reloadData()
        }
    }

    open var contentFont: UIFont = UIFont.systemFont(ofSize: 12) {
        didSet {
            self.tableView.reloadData()
        }
    }

    open var dateTimeFont: UIFont = UIFont.systemFont(ofSize: 10) {
        didSet {
            self.tableView.reloadData()
        }
    }

    open var textColor: UIColor = UIColor.gray {
        didSet {
            self.tableView.reloadData()
        }
    }

    open var highlightTextColor: UIColor = UIColor(red:0.95, green:0.75, blue:0.25, alpha:1.00) {
        didSet {
            self.tableView.reloadData()
        }
    }

    open var lineWidth: CGFloat = 1 {
        didSet {
            self.tableView.reloadData()
        }
    }

    open var circleRadius: CGFloat = 4 {
        didSet {
            self.tableView.reloadData()
        }
    }

    open var highlightCircleBorderWidth: CGFloat = 1 {
        didSet {
            self.tableView.reloadData()
        }
    }

    open var highlightCircleBorderColor: UIColor = UIColor(red:0.97, green:0.88, blue:0.65, alpha:1.00) {
        didSet {
            self.tableView.reloadData()
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.addTableView()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addTableView()
    }

    open override func updateConstraints() {
        super.updateConstraints()
        self.tableView.snp.updateConstraints { (make) in
            make.edges.equalTo(self)
        }
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.recordHeight(self.frame.width, indexPath: indexPath)
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let dataSource = self.dataSource {
            return dataSource.numberOfTimeLineRecordCount(self)
        }
        return 0
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimeLineViewCell", for: indexPath) as! TimeLineViewCell
        if let dataSource = self.dataSource {
            var textColor: UIColor
            let isHighlight = dataSource.timeLineView(self, isHighlight: indexPath)
            if isHighlight {
                textColor = self.highlightTextColor
            } else {
                textColor = self.textColor
            }
            var lineWidth: CGFloat
            if indexPath.row == dataSource.numberOfTimeLineRecordCount(self) - 1 {
                lineWidth = 0
            } else {
                lineWidth = self.lineWidth
            }

            cell.circleView.backgroundColor = textColor
            if isHighlight {
                cell.circleView.layer.borderWidth = self.highlightCircleBorderWidth
                cell.circleView.layer.borderColor = self.highlightCircleBorderColor.cgColor
            } else {
                cell.circleView.layer.borderWidth = 0
                cell.circleView.layer.borderColor = textColor.cgColor
            }
            cell.lineView.backgroundColor = self.textColor
            cell.titleLabel.text = dataSource.timeLineView(self, title: indexPath)
            cell.titleLabel.font = self.titleFont
            cell.titleLabel.textColor = textColor

            cell.contentLabel.text = dataSource.timeLineView(self, content: indexPath)
            cell.contentLabel.font = self.contentFont
            cell.contentLabel.textColor = textColor

            cell.dateTimeLabel.text = dataSource.timeLineView(self, dateTime: indexPath)
            cell.dateTimeLabel.font = self.dateTimeFont
            cell.dateTimeLabel.textColor = textColor

            var padding: UIEdgeInsets
            if indexPath.row == 0 {
                padding = UIEdgeInsets(top: self.padding.top, left: self.padding.left, bottom: 0, right: self.padding.right)
            } else {
                padding = UIEdgeInsets(top: 0, left: self.padding.left, bottom: 0, right: self.padding.right)
            }
            cell.updateContentViewConstraints(padding,lineWidth: lineWidth, circleRadius: self.circleRadius)
        }
        return cell
    }

    open func recordHeight(_ width: CGFloat, indexPath: IndexPath) -> CGFloat {
        if (width <= 0) {
            return 0
        }

        if let dataSource = self.dataSource {
            let maxWidth = width - self.padding.left - self.padding.right - (self.circleRadius * 2) - 25
            let titleHight = dataSource.timeLineView(self, title: indexPath).height(self.titleFont, maxWidth: maxWidth)
            let contentHight = dataSource.timeLineView(self, content: indexPath).height(self.contentFont, maxWidth: maxWidth)
            let dateTimeHight = dataSource.timeLineView(self, dateTime: indexPath).height(self.dateTimeFont, maxWidth: maxWidth)
            if indexPath.row == 0 {
                return self.padding.top + titleHight + 2 + contentHight + 10 + dateTimeHight + 20
            }
            if indexPath.row == dataSource.numberOfTimeLineRecordCount(self) - 1 {
                return titleHight + 2 + contentHight + 10 + dateTimeHight + self.padding.bottom
            }
            return titleHight + 2 + contentHight + 10 + dateTimeHight + 20
        }
        return 0
    }

    fileprivate func addTableView() {
        self.backgroundColor = UIColor.white
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.allowsSelection = false
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.tableView.layoutMargins = UIEdgeInsets.zero
        self.tableView.cellLayoutMarginsFollowReadableWidth = false
        self.tableView.backgroundColor = self.backgroundColor
        self.tableView.register(TimeLineViewCell.classForCoder(), forCellReuseIdentifier: "TimeLineViewCell")
        self.addSubview(self.tableView)
    }
}
