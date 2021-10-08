//width: 40, height: 50

import UIKit

class NotificationButton: UIButton {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        config()

    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        config()
    }
    
    func config() {
        self.setImage(UIImage(named: "ic_Notifi")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), for: .normal)
        self.setTitle(nil, for: .normal)
        self.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        self.addTarget(self, action: #selector(ButtonDidTap(_:)), for: .touchUpInside)
        
    }
    
    @objc func ButtonDidTap(_ sender: UIButton) {
        print("hello notifi")
    }
    
}
