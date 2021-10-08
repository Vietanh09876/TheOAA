//
//  EvaluationComponentCell.swift
//  TheOAA
//
//  Created by Nguyễn Việt Anh on 15/09/2021.
//

import UIKit

class EvaluationComponentCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var imageview: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewConfig()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func viewConfig() {
        self.backgroundColor = .clear
        
        label.text = "Hello"
        label.textColor = UIColor().SubTextColor(alpha: 1)
        label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        label.textAlignment = .left
        label.sizeToFit()
        
        imageview.contentMode = .scaleToFill
    }
    
    
}
