
import UIKit

class AchievementCell: UITableViewCell {

    @IBOutlet weak var achivementImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var id: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewConfig()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
    func viewConfig() {
        self.backgroundColor = .clear
        
        achivementImage.contentMode = .scaleAspectFit
        
        nameLabel.textColor = UIColor().SubTextColor(alpha: 1)
        nameLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        nameLabel.numberOfLines = 2
    }
    
}
