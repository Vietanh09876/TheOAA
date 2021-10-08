//height: 55, opened:315

import UIKit

class SectionButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        config()
    }
    
    func config() {
        self.setBackgroundImage(UIImage(named: "im_Section"), for: .normal)
        self.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        self.setTitle("", for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        self.setTitleColor(UIColor().SubTextColor(alpha: 1), for: .normal)
        
        
    }
}
