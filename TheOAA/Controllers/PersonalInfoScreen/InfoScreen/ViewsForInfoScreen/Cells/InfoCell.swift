//height = 50

import UIKit

class InfoCell: UITableViewCell {

    @IBOutlet weak var decoImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewConfig()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
    func viewConfig() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red: 0.01, green: 0.46, blue: 0.25, alpha: 1.00).cgColor
        
        decoImage.image = UIImage(named: "im_InfoCell")
        decoImage.contentMode = .scaleToFill
        
        titleLabel.textAlignment = .left
        titleLabel.textColor = UIColor().MainTextColor(alpha: 1)
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        titleLabel.numberOfLines = 0
        
        contentLabel.textColor = UIColor().SubTextColor(alpha: 1)
        contentLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        
    }
    
}
