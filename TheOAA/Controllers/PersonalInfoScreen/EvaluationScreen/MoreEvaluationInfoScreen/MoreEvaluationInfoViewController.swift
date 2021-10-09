//
//  MoreEvaluationInfoViewController.swift
//  TheOAA
//
//  Created by Nguyễn Việt Anh on 08/10/2021.
//

import UIKit

class MoreEvaluationInfoViewController: UIViewController {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var oldscoreTitleLabel: UILabel!
    @IBOutlet weak var oldscorecontentTextView: UITextView!
    @IBOutlet weak var equationTitleLabel: UILabel!
    @IBOutlet weak var equationImage: UIImageView!
    @IBOutlet weak var oldscoreTextViewHeightContraint: NSLayoutConstraint!
    
    var previousscorearray = [Float]()
    var scorearray = [Float]()
    var ratedscorearray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewConfig()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        oldscoreTextViewHeightContraint.constant = oldscorecontentTextView.contentSize.height
        print(oldscorecontentTextView.contentSize.height)
    }
    
    private func viewConfig() {
        self.view.backgroundColor = UIColor().ContainerViewColor()
        
        
        backgroundImage.image = UIImage(named: "im_BackgroundDecoBott")
        backgroundImage.contentMode = .scaleAspectFill
        
        equationImage.contentMode = .scaleAspectFit
        equationImage.image = UIImage(named: "OverallScoreEquation")
        
        oldscoreTitleLabel.text = "Đánh Giá Hiện Tại So Với Điểm Cũ:"
        oldscoreTitleLabel.numberOfLines = 0
        oldscoreTitleLabel.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        oldscoreTitleLabel.textColor = UIColor().MainTextColor(alpha: 1)
        
        equationTitleLabel.text = "Công Thức Tính Điểm Tổng Quát:"
        equationTitleLabel.numberOfLines = 0
        equationTitleLabel.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        equationTitleLabel.textColor = UIColor().MainTextColor(alpha: 1)
        
        oldscorecontentTextView.textColor = UIColor().SubTextColor(alpha: 1)
        oldscorecontentTextView.backgroundColor = .clear
        oldscorecontentTextView.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        oldscorecontentTextView.isEditable = false
        oldscorecontentTextView.showsVerticalScrollIndicator = false
        oldscorecontentTextView.text = """
- Học Lực: \(ratedscorearray[0]) \(scoreDifference(x: 0))

- Thể Chất: \(ratedscorearray[1]) \(scoreDifference(x: 1))

- Tư Duy: \(ratedscorearray[2]) \(scoreDifference(x: 2))

- Đóng Góp Cộng Đồng: \(ratedscorearray[3]) \(scoreDifference(x: 3))

- Tổng Quát: \(ratedscorearray[4]) \(scoreDifference(x: 4))

- Tín Nhiệm: \(Int(scorearray[5])) \(scoreDifference(x: 5))
"""
    }
    
    func scoreDifference(x: Int) -> String {
        if scorearray[x] - previousscorearray[x] > 0 {
            return "(Tăng \(Int(scorearray[x] - previousscorearray[x])))"
        }
        else {
            return "(Giảm \(-Int(scorearray[x] - previousscorearray[x])))"
        }
    }
}
