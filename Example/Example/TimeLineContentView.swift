import UIKit
import SnapKit

class TimeLineContentView: UIView {
    
    let titleLabel = UILabel()
    let contentLabel = UILabel()
    let dateTimeLabel = UILabel()
    
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
        self.titleLabel.snp.remakeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.top.right.top.equalTo(self)
            make.height.equalTo(12)
        }
        self.contentLabel.snp.remakeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(6)
            make.height.equalTo(12)
        }
        self.dateTimeLabel.snp.remakeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self)
            make.top.equalTo(self.contentLabel.snp.bottom).offset(6)
            make.height.equalTo(10)
        }
    }

    fileprivate func initViews() {
        self.titleLabel.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(self.titleLabel)
        self.contentLabel.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(self.contentLabel)
        self.dateTimeLabel.font = UIFont.systemFont(ofSize: 10)
        self.addSubview(self.dateTimeLabel)
    }
}
