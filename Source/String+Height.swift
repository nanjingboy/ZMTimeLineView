import UIKit

extension String {

    func height(_ font:UIFont, maxWidth: CGFloat) -> CGFloat {
        if self.isEmpty {
            return 0
        }
        let size = (self as NSString).size(attributes: [NSFontAttributeName: font])
        return ceil(size.width / maxWidth) * size.height
    }
}
