import UIKit
import SnapKit

class TimeLineRecordCircleView : UIView {

    var isHighlight: Bool = false {
        didSet {
            self.updateCircleViewStyle()
        }
    }
    
    var lineWidth: CGFloat = 1
    var lineColor: UIColor = TimeLineColors.defaultColor {
        didSet {
            self.lineView.backgroundColor = self.lineColor
        }
    }

    var circleRadius: CGFloat = 3.5 {
        didSet {
            self.updateCircleViewStyle()
        }
    }

    var circleColor: UIColor = TimeLineColors.defaultColor {
        didSet {
            self.updateCircleViewStyle()
        }
    }
    
    var highlightCircleBorderWidth: CGFloat = 2 {
        didSet {
            self.updateCircleViewStyle()
        }
    }

    var highlightCircleBorderColor: UIColor = TimeLineColors.highlightBorderColor {
        didSet {
            self.updateCircleViewStyle()
        }
    }

    fileprivate let circleView = UIView()
    fileprivate let lineView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initViews()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        var circleViewSize:CGFloat
        if self.isHighlight {
            circleViewSize = (self.circleRadius + self.highlightCircleBorderWidth) * 2
        } else {
            circleViewSize = self.circleRadius * 2
        }
        self.circleView.snp.remakeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(self)
            make.size.equalTo(circleViewSize)
        }
        self.lineView.snp.remakeConstraints { (make) in
            make.centerX.equalTo(self.circleView)
            make.width.equalTo(self.lineWidth)
            make.top.equalTo(self.circleView.snp.bottom)
            make.bottom.equalTo(self)
        }
    }

    fileprivate func initViews() {
        self.addSubview(self.circleView)
        self.lineView.backgroundColor = self.lineColor
        self.addSubview(self.lineView)
        updateCircleViewStyle()
    }

    fileprivate func updateCircleViewStyle() {
        self.circleView.backgroundColor = self.circleColor
        if self.isHighlight {
            self.circleView.layer.borderWidth = self.highlightCircleBorderWidth
            self.circleView.layer.cornerRadius = self.highlightCircleBorderWidth + self.circleRadius
            self.circleView.layer.borderColor = self.highlightCircleBorderColor.cgColor
        } else {
            self.circleView.layer.borderWidth = 0
            self.circleView.layer.cornerRadius = self.circleRadius
            self.circleView.layer.borderColor = nil
        }
    }
}
