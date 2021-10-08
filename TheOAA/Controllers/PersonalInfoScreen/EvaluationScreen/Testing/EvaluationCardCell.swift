//
//  EvaluationCardCell.swift
//  TheOAA
//
//  Created by Nguyễn Việt Anh on 29/09/2021.
//

import UIKit

class EvaluationCardCell: UITableViewCell {

    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var arrowImage: UIImageView!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var commentTextViewHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewConfig()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    private func viewConfig() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red: 0.16, green: 0.26, blue: 0.13, alpha: 1.00).cgColor
        
        cellImage.contentMode = .scaleToFill
        
        arrowImage.contentMode = .scaleToFill
        
        titleLabel.textColor = UIColor().MainTextColor(alpha: 1)
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        titleLabel.numberOfLines = 0
        
        contentLabel.textColor = UIColor().SubTextColor(alpha: 1)
        contentLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        
        commentTextView.isHidden = true
        commentTextView.isScrollEnabled = true
        commentTextView.backgroundColor = .white
        commentTextView.textColor = UIColor().SubTextColor(alpha: 1)
        commentTextView.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        commentTextView.addDoneButtonOnKeyboard()
        commentTextView.delegate = self
    }
    
}

extension EvaluationCardCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        
    }
}
