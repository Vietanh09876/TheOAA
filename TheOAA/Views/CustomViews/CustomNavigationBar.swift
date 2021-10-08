//height: 45
//Button width: 126, height: 38

import UIKit

class CustomNavigationBar: UIView {
    
    @IBOutlet weak var navigationbarImage: UIImageView!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
        viewConfig()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
        viewConfig()
    }
    
    func commonInit() {
        
        guard let view = LoadViewFromNib() else { return }
        
        view.backgroundColor = .clear
        view.frame = self.bounds
        self.addSubview(view)
        
    }
    
    func LoadViewFromNib() -> UIView? {
        let nib = UINib(nibName: "CustomNavigationBar", bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first! as? UIView
    }
    
    func viewConfig() {
        navigationbarImage.image = UIImage(named: "im_NavigationBar")
        navigationbarImage.contentMode = .scaleToFill
        
        backButton.setImage(UIImage(named: "ic_BackButton")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), for: .normal)
        
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
    }
    
}
