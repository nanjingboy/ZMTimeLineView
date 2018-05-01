import UIKit
import SnapKit

open class TimeLineView: UIStackView {
    
    open weak var dataSource: TimeLineViewDataSource?

    open var bgColor: UIColor = UIColor.white
    open var padding: UIEdgeInsets = UIEdgeInsets(top: 10, left: 16, bottom: 0, right: 16)
    open var recordBottomHeight: CGFloat = 20
    
    open var lineWidth: CGFloat = 1
    open var lineColor: UIColor = TimeLineColors.defaultColor

    open var circleRadius: CGFloat = 3.5
    open var circleColor: UIColor = TimeLineColors.defaultColor
    open var highlightCircleBorderWidth: CGFloat = 2
    open var highlightCircleBorderColor: UIColor = TimeLineColors.highlightBorderColor
    open var highlightCircleColor: UIColor = TimeLineColors.highlightColor

    open func reloadData() {
        self.axis = .vertical
        for arrangedSubview in self.arrangedSubviews {
            self.removeArrangedSubview(arrangedSubview)
        }
        if let dataSource = self.dataSource {
            let count = dataSource.numberOfTimeLineRecordCount(self)
            for index in 0..<count {
                let cell = UIView()
                cell.backgroundColor = self.bgColor
                self.addArrangedSubview(cell)

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

                var cellHeight: CGFloat
                var circleViewTopOffset: CGFloat
                var circleViewBottomOffset: CGFloat
                let contentViewHeight = dataSource.timeLineView(self, contentViewHeight: index)
                if index == 0 {
                    circleViewTopOffset = self.padding.top
                    circleViewBottomOffset = 0
                    cellHeight = self.padding.top + contentViewHeight + self.recordBottomHeight
                } else if index == count - 1 {
                    circleViewTopOffset = 0
                    circleViewBottomOffset = self.padding.bottom
                    cellHeight = self.padding.bottom + contentViewHeight + self.recordBottomHeight
                } else {
                    circleViewTopOffset = 0
                    circleViewBottomOffset = 0
                    cellHeight = contentViewHeight + self.recordBottomHeight
                }
                cell.snp.makeConstraints { (make) in
                    make.height.equalTo(cellHeight)
                }
                circleView.snp.makeConstraints { (make) in
                    make.left.equalTo(cell).offset(self.padding.left)
                    make.width.equalTo((self.circleRadius + self.highlightCircleBorderWidth) * 2)
                    make.top.equalTo(cell).offset(circleViewTopOffset)
                    make.bottom.equalTo(cell).offset(-circleViewBottomOffset)
                }
                contentView.snp.makeConstraints { (make) in
                    make.left.equalTo(circleView.snp.right)
                    make.right.equalTo(cell).offset(-self.padding.right)
                    make.top.equalTo(circleView)
                    make.height.equalTo(contentViewHeight)
                }
            }
        }
    }
}
