//
//  NewsBoardCell.swift
//  TheOAA
//
//  Created by Nguyễn Việt Anh on 11/09/2021.
//

import UIKit

class NewsBoardCell: UICollectionViewCell {

    
    @IBOutlet weak var ImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        ImageView.contentMode = .scaleAspectFill
    }

}
