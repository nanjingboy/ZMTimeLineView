import UIKit
import SnapKit

open class TimeLineView: UIStackView {

    open var dataSource: TimeLineViewDataSource?

    open var padding: UIEdgeInsets = UIEdgeInsets(top: 10, left: 18, bottom: 10, right: 33)

    open var titleFont: UIFont = UIFont.systemFont(ofSize: 12)
    open var contentFont: UIFont = UIFont.systemFont(ofSize: 12)
    open var dateTimeFont: UIFont = UIFont.systemFont(ofSize: 10)

    open var textColor: UIColor = UIColor.gray
    open var highlightTextColor: UIColor = UIColor(red:0.95, green:0.75, blue:0.25, alpha:1.00)

    open var lineWidth: CGFloat = 1
    open var circleRadius: CGFloat = 4
    open var highlightCircleBorderWidth: CGFloat = 1
    open var highlightCircleBorderColor: UIColor = UIColor(red:0.97, green:0.88, blue:0.65, alpha:1.00)

    open func reloadData() {
        self.axis = .vertical
        for subView in self.arrangedSubviews {
            self.removeArrangedSubview(subView)
        }
        if let dataSource = self.dataSource {
            let count = dataSource.numberOfTimeLineRecordCount(self)
            for index in 0..<count {
                let height = self.timeLineView(self, heightForRowAt: index)
                let cell = self.timeLineView(self, cellForRowAt: index)
                self.addArrangedSubview(cell)
                cell.snp.makeConstraints({ (make) in
                    make.height.equalTo(height)
                })
            }
        }
    }

    func timeLineView(_ timeLineView: TimeLineView, heightForRowAt index: Int) -> CGFloat {
        if let dataSource = self.dataSource {
            let width = dataSource.timeLineView(timeLineView, widthForRowAt: index)
            let maxWidth = width - self.padding.left - self.padding.right - (self.circleRadius * 2) - 25
            let titleHight = dataSource.timeLineView(timeLineView, title: index).height(self.titleFont, maxWidth: maxWidth)
            let contentHight = dataSource.timeLineView(timeLineView, content: index).height(self.contentFont, maxWidth: maxWidth)
            let dateTimeHight = dataSource.timeLineView(timeLineView, dateTime: index).height(self.dateTimeFont, maxWidth: maxWidth)
            let count = dataSource.numberOfTimeLineRecordCount(timeLineView)
            if count == 1 {
                return self.padding.top + titleHight + 2 + contentHight + 10 + dateTimeHight + self.padding.bottom
            }
            if index == 0 {
                return self.padding.top + titleHight + 2 + contentHight + 10 + dateTimeHight + 20
            }
            if index == count - 1 {
                return titleHight + 2 + contentHight + 10 + dateTimeHight + self.padding.bottom
            }
            return titleHight + 2 + contentHight + 10 + dateTimeHight + 20
        }
        return 0
    }

    func timeLineView(_ timeLineView: TimeLineView, cellForRowAt index: Int) -> TimeLineViewCell {
        let cell = TimeLineViewCell()
        if let dataSource = self.dataSource {
            var textColor: UIColor
            let count = dataSource.numberOfTimeLineRecordCount(timeLineView)
            let isHighlight = dataSource.timeLineView(timeLineView, isHighlight: index)
            if isHighlight {
                textColor = self.highlightTextColor
            } else {
                textColor = self.textColor
            }
            var lineWidth: CGFloat
            if index > 0 && index == count - 1 {
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
            cell.titleLabel.text = dataSource.timeLineView(timeLineView, title: index)
            cell.titleLabel.font = self.titleFont
            cell.titleLabel.textColor = textColor

            cell.contentLabel.text = dataSource.timeLineView(timeLineView, content: index)
            cell.contentLabel.font = self.contentFont
            cell.contentLabel.textColor = textColor

            cell.dateTimeLabel.text = dataSource.timeLineView(timeLineView, dateTime: index)
            cell.dateTimeLabel.font = self.dateTimeFont
            cell.dateTimeLabel.textColor = textColor

            var padding: UIEdgeInsets
            if count == 1 {
                padding = UIEdgeInsets(top: self.padding.top, left: self.padding.left, bottom: self.padding.bottom, right: self.padding.right)
            } else if index == 0 {
                padding = UIEdgeInsets(top: self.padding.top, left: self.padding.left, bottom: 0, right: self.padding.right)
            } else {
                padding = UIEdgeInsets(top: 0, left: self.padding.left, bottom: 0, right: self.padding.right)
            }
            cell.updateContentViewConstraints(padding,
                                              lineWidth: lineWidth,
                                              circleRadius: self.circleRadius,
                                              width: dataSource.timeLineView(timeLineView, widthForRowAt: index))
        }
        return cell
    }
}
