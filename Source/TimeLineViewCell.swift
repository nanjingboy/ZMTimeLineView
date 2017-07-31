import UIKit
import SnapKit

 class TimeLineViewCell: UIView {

    let circleView = UIView()
    let lineView = UIView()
    let titleLabel = UILabel()
    let contentLabel = UILabel()
    let dateTimeLabel = UILabel()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.addContentViews()
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addContentViews()
    }

    func addContentViews() {
        self.titleLabel.numberOfLines = 0
        self.contentLabel.numberOfLines = 0
        self.dateTimeLabel.numberOfLines = 0

        self.addSubview(self.circleView)
        self.addSubview(self.lineView)
        self.addSubview(self.titleLabel)
        self.addSubview(self.titleLabel)
        self.addSubview(self.contentLabel)
        self.addSubview(self.dateTimeLabel)
    }

    func updateContentViewConstraints(_ padding: UIEdgeInsets,
                                      lineWidth: CGFloat,
                                      circleRadius: CGFloat,
                                      width: CGFloat) {
        self.circleView.layer.cornerRadius = circleRadius
        self.circleView.snp.updateConstraints { (make) in
            make.top.equalTo(self).offset(padding.top)
            make.left.equalTo(self).offset(padding.left)
            make.size.equalTo(circleRadius * 2)
        }
        self.lineView.snp.updateConstraints { (make) in
            make.top.equalTo(self.circleView.snp.bottom)
            make.bottom.equalTo(self).offset(-padding.bottom)
            make.centerX.equalTo(self.circleView)
            make.width.equalTo(lineWidth)
        }
        let contentOffsetX = padding.left + (circleRadius * 2) + 25
        let maxWidth = width - contentOffsetX - padding.right
        self.titleLabel.snp.updateConstraints { (make) in
            make.left.equalTo(self).offset(contentOffsetX)
            make.right.equalTo(self).offset(-padding.right)
            make.top.equalTo(self).offset(padding.top)
            make.height.equalTo(self.titleLabel.text!.height(self.titleLabel.font, maxWidth: maxWidth))
        }
        self.contentLabel.snp.updateConstraints { (make) in
            make.left.equalTo(self).offset(contentOffsetX)
            make.right.equalTo(self).offset(-padding.right)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(2)
            make.height.equalTo(self.contentLabel.text!.height(self.contentLabel.font, maxWidth: maxWidth))
        }
        self.dateTimeLabel.snp.updateConstraints { (make) in
            make.left.equalTo(self).offset(contentOffsetX)
            make.right.equalTo(self).offset(-padding.right)
            make.top.equalTo(self.contentLabel.snp.bottom).offset(10)
            make.height.equalTo(self.dateTimeLabel.text!.height(self.dateTimeLabel.font, maxWidth: maxWidth))
        }
    }
}
