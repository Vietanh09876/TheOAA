//
//  MemberListCell.swift
//  TheOAA
//
//  Created by Nguyễn Việt Anh on 20/09/2021.
//

import UIKit

class MemberListCell: UITableViewCell {

    
    @IBOutlet weak var ordinalnumberLabel: UILabel!
    @IBOutlet weak var nameidLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewConfig()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    private func viewConfig() {
        self.backgroundColor = .clear
        
        ordinalnumberLabel.textColor = UIColor().SubTextColor(alpha: 1)
        ordinalnumberLabel.font = UIFont.systemFont(ofSize: 17)
        
        nameidLabel.textColor = UIColor().SubTextColor(alpha: 1)
        nameidLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        nameidLabel.numberOfLines = 2
        nameidLabel.text = """
            Name
            #id
            """
        
    }
    
}
