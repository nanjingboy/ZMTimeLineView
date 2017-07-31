import Foundation

public protocol TimeLineViewDataSource {

    func numberOfTimeLineRecordCount(_ timeLineView: TimeLineView) -> Int

    func timeLineView(_ timeLineView: TimeLineView, widthForRowAt index: Int) -> CGFloat
    func timeLineView(_ timeLineView: TimeLineView, title index: Int) -> String
    func timeLineView(_ timeLineView: TimeLineView, content index: Int) -> String
    func timeLineView(_ timeLineView: TimeLineView, dateTime index: Int) -> String
    func timeLineView(_ timeLineView: TimeLineView, isHighlight index: Int) -> Bool
}
