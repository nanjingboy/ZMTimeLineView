import Foundation

public protocol TimeLineViewDataSource: class {
    
    func numberOfTimeLineRecordCount(_ timeLineView: TimeLineView) -> Int

    func timeLineView(_ timeLineView: TimeLineView, isHighlight index: Int) -> Bool
    func timeLineView(_ timeLineView: TimeLineView, contentViewHeight contentView: UIView, index: Int) -> CGFloat
    func timeLineView(_ timeLineView: TimeLineView, contentView index: Int) -> UIView
}
