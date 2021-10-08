//height = 100

import UIKit

class CommunicationCell: UITableViewCell {
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var titlenameLabel: UILabel!
    @IBOutlet weak var titlephoneLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
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
        
        cellImage.image = UIImage(named: "im_BigInfoCell")
        cellImage.contentMode = .scaleToFill
        
        titlenameLabel.text = "Họ Tên"
        titlenameLabel.textColor = UIColor().MainTextColor(alpha: 1)
        titlenameLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        titlenameLabel.numberOfLines = 0
        
        titlephoneLabel.text = "SĐT"
        titlephoneLabel.textColor = UIColor().MainTextColor(alpha: 1)
        titlephoneLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        titlephoneLabel.numberOfLines = 0
        
        
        nameLabel.textColor = UIColor().SubTextColor(alpha: 1)
        nameLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        
        
        phoneLabel.textColor = UIColor().SubTextColor(alpha: 1)
        phoneLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
    }
    
}
