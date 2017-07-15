import Foundation

public protocol TimeLineViewDataSource {

    func numberOfTimeLineRecordCount(_ timeLineView: TimeLineView) -> Int
    func timeLineView(_ timeLineView: TimeLineView, title indexPath: IndexPath) -> String
    func timeLineView(_ timeLineView: TimeLineView, content indexPath: IndexPath) -> String
    func timeLineView(_ timeLineView: TimeLineView, dateTime indexPath: IndexPath) -> String
    func timeLineView(_ timeLineView: TimeLineView, isHighlight indexPath: IndexPath) -> Bool
}
