//
//  SettingCell.swift
//  TheOAA
//
//  Created by Nguyễn Việt Anh on 07/10/2021.
//

import UIKit

class SettingCell: UITableViewCell {

    @IBOutlet weak var settingimageView: UIImageView!
    @IBOutlet weak var mylabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewConfig()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    private func viewConfig() {
        settingimageView.contentMode = .scaleToFill
        
        self.backgroundColor = .clear
        
        mylabel.textColor = UIColor().MainTextColor(alpha: 1)
        mylabel.font = UIFont.systemFont(ofSize: 22, weight: .medium)
    }
    
}
