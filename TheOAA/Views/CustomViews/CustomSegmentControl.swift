// height: 40

import UIKit

class CustomSegmentControl: UIView {

    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var seccondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    
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
        let nib = UINib(nibName: "CustomSegmentControl", bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first! as? UIView
    }
    
    
    func viewConfig() {
        let buttonsarray = [firstButton,seccondButton,thirdButton]
        
        for (index, button) in buttonsarray.enumerated() {
            
            button?.setTitle(nil, for: .normal)
            button?.setBackgroundImage(UIImage(named: "im_CustomSegment"), for: .normal)
            button?.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            button?.adjustsImageWhenHighlighted = false
            button?.tag = index+1
            button?.addTarget(self, action: #selector(buttonDidTap(_:)), for: .touchUpInside)
        }
    }
    
    
    
    @objc func buttonDidTap(_ sender: UIButton) {
        changeImageWhenTapped(pressedbutton: sender)
        switch sender.tag {
        case 1:
            pressedbuttonindex?(1)
            print("seg 1")
            
        case 2:
            pressedbuttonindex?(2)
            print("seg 2")
            
        case 3:
            pressedbuttonindex?(3)
            print("seg 3")
            
        default:
            print("seg 0")
            return
        }
    }
    
    func changeImageWhenTapped(pressedbutton: UIButton) {
        var buttonsarray = [firstButton,seccondButton,thirdButton]
        
        pressedbutton.setBackgroundImage(UIImage(named: "im_SelectedSegment"), for: .normal)
        buttonsarray.remove(at: pressedbutton.tag-1)
        for button in buttonsarray {
            button?.setBackgroundImage(UIImage(named: "im_CustomSegment"), for: .normal)
        }
    }
    
}
