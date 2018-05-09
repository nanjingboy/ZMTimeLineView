import UIKit
import SnapKit

open class TimeLineView: UIView {

    open weak var dataSource: TimeLineViewDataSource?

    open var bgColor: UIColor = UIColor.white
    open var topPadding: CGFloat = 10
    open var leftPadding: CGFloat = 16
    open var rightPadding: CGFloat = 16
    open var recordBottomHeight: CGFloat = 20

    open var lineWidth: CGFloat = 1
    open var lineColor: UIColor = TimeLineColors.defaultColor

    open var circleRadius: CGFloat = 3.5
    open var circleColor: UIColor = TimeLineColors.defaultColor
    open var highlightCircleBorderWidth: CGFloat = 2
    open var highlightCircleBorderColor: UIColor = TimeLineColors.highlightBorderColor
    open var highlightCircleColor: UIColor = TimeLineColors.highlightColor

    open func reloadData(_ updateConstraintCallback: (CGFloat) -> Void) {
        for subView in self.subviews {
            subView.removeFromSuperview()
        }
        var totalHeight: CGFloat = 0
        if let dataSource = self.dataSource {
            let count = dataSource.numberOfTimeLineRecordCount(self)
            for index in 0..<count {
                let cell = UIView()
                cell.backgroundColor = self.bgColor
                self.addSubview(cell)

                let circleView = TimeLineRecordCircleView()
                circleView.backgroundColor = self.bgColor
                circleView.lineWidth = self.lineWidth
                circleView.lineColor = self.lineColor
                circleView.circleRadius = self.circleRadius
                circleView.highlightCircleBorderWidth = self.highlightCircleBorderWidth
                circleView.highlightCircleBorderColor = self.highlightCircleBorderColor
                circleView.isHighlight = dataSource.timeLineView(self, isHighlight: index)
                if circleView.isHighlight {
                    circleView.circleColor = self.highlightCircleColor
                } else {
                    circleView.circleColor = self.circleColor
                }
                cell.addSubview(circleView)
                let contentView = dataSource.timeLineView(self, contentView: index)
                cell.addSubview(contentView)

                let contentViewHeight = dataSource.timeLineView(self, contentViewHeight: contentView, index: index)
                let cellHeight = contentViewHeight + self.recordBottomHeight
                cell.snp.makeConstraints { (make) in
                    make.left.right.equalTo(self)
                    make.top.equalTo(self).offset(totalHeight)
                    make.height.equalTo(cellHeight)
                }
                totalHeight += cellHeight
                circleView.snp.makeConstraints { (make) in
                    make.left.equalTo(cell).offset(self.leftPadding)
                    make.width.equalTo((self.circleRadius + self.highlightCircleBorderWidth) * 2)
                    make.top.equalTo(cell).offset(index == 0 ? self.topPadding : 0)
                    make.bottom.equalTo(cell)
                }
                contentView.snp.makeConstraints { (make) in
                    make.left.equalTo(circleView.snp.right)
                    make.right.equalTo(cell).offset(-self.rightPadding)
                    make.top.equalTo(circleView)
                    make.height.equalTo(contentViewHeight)
                }
            }
        }
        updateConstraintCallback(totalHeight)
    }
}
