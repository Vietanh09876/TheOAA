//height: 38, spac -10(-18)

import UIKit

class CustomTabBar: UIView {
    
    @IBOutlet weak var tabbarImage: UIImageView!
    
    @IBOutlet weak var LeftButton: UIButton!
    @IBOutlet weak var MiddleButton: UIButton!
    @IBOutlet weak var RightButton: UIButton!
    
    var buttons = [UIButton]()
    var pressedbuttonindex: ((Int) -> Void)?
    
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
        let nib = UINib(nibName: "CustomTabBar", bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first! as? UIView
    }
    
    func viewConfig() {
        tabbarImage.image = UIImage(named: "im_NoneTabbar")
        tabbarImage.contentMode = .scaleToFill
        
        
        
        
        buttons.append(contentsOf: [LeftButton, MiddleButton, RightButton])
        
        for (index, element) in buttons.enumerated() {
            element.backgroundColor = .clear
            element.setTitleColor(UIColor().MainTextColor(alpha: 1), for: .normal)
            element.setTitle(nil, for: .normal)
            element.tag = index+1
            element.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
            element.addTarget(self, action: #selector(ButtonDidTap(_:)), for: .touchUpInside)
        }
        
        
        
    }
    
    @objc func ButtonDidTap(_ sender: UIButton) {
        changeColorWhenTapped(pressedbutton: sender)
        switch sender.tag {
        case 1:
            pressedbuttonindex?(1)
            tabbarImage.image = UIImage(named: "im_LeftTabbar")
            print("left")
                
        case 2:
            pressedbuttonindex?(2)
            tabbarImage.image = UIImage(named: "im_MiddleTabbar")
            print("midd")
            
        case 3:
            pressedbuttonindex?(3)
            tabbarImage.image = UIImage(named: "im_RightTabbar")
            print("right")
            
        default:
            print("0")
            return
        }
    }
    
    func changeColorWhenTapped(pressedbutton: UIButton) {
        var buttonsarray = buttons
        
        pressedbutton.setTitleColor(.white, for: .normal)
        buttonsarray.remove(at: pressedbutton.tag-1)
        for button in buttonsarray {
            button.setTitleColor(UIColor().MainTextColor(alpha: 1), for: .normal)
        }
    }
    
}
