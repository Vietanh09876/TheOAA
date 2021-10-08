//
//  MainAchievementCell.swift
//  TheOAA
//
//  Created by Nguyễn Việt Anh on 21/09/2021.
//

import UIKit

class MainAchievementCell: UITableViewCell {
        
    @IBOutlet weak var pictureframeImage: UIImageView!
    @IBOutlet weak var contentbackgroundImage: UIImageView!
    @IBOutlet weak var achievementImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var summarizeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var rewardLabel: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewConfig()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    private func viewConfig () {
        self.backgroundColor = .clear
        
        pictureframeImage.image = UIImage(named: "im_AchievementPicFrame")
        pictureframeImage.contentMode = .scaleToFill
        
        contentbackgroundImage.image = UIImage(named: "im_AchievementContent")
        contentbackgroundImage.contentMode = .scaleToFill
        
        achievementImage.image = UIImage(named: "Unknown_person")
        achievementImage.contentMode = .scaleAspectFit
        
        nameLabel.textColor = UIColor().MainTextColor(alpha: 1)
        nameLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        nameLabel.text = "Name"
        
        idLabel.textColor = UIColor.darkGray
        idLabel.font = UIFont.systemFont(ofSize: 12)
        idLabel.text = "#id"
        
        summarizeLabel.textColor = UIColor().SubTextColor(alpha: 1)
        summarizeLabel.font = UIFont.systemFont(ofSize: 14)
        summarizeLabel.numberOfLines = 2
        summarizeLabel.text = "Summarize"
        
        dateLabel.textColor = UIColor().SpecialTextColor()
        dateLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        dateLabel.text = "- Thời Gian: "
        
        rewardLabel.textColor = UIColor().SpecialTextColor()
        rewardLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        rewardLabel.text = "- Phần Thưởng: "
    }
    
}
