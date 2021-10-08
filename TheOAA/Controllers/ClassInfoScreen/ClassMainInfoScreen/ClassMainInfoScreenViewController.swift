//
//  ClassMainInfoScreenViewController.swift
//  TheOAA
//
//  Created by Nguyễn Việt Anh on 20/09/2021.
//

import UIKit

class ClassMainInfoScreenViewController: UIViewController {
    
    //MARK: - Outlet
    @IBOutlet weak var FirstTitleLabel: UILabel!
    @IBOutlet weak var FirstTextView: UITextView!
    @IBOutlet weak var SeccondTitleLabel: UILabel!
    @IBOutlet weak var SeccondContentLabel: UILabel!
    @IBOutlet weak var ThirdTitleLabel: UILabel!
    @IBOutlet weak var ThirdContentLabel: UILabel!
    @IBOutlet weak var FourthTitleLabel: UILabel!
    @IBOutlet weak var FourthContentLabel: UILabel!
    @IBOutlet weak var TextViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollViewContainer: UIView!
    @IBOutlet weak var AcceptChangeButton: UIButton!
    @IBOutlet weak var DeclineChangeButton: UIButton!
    
    //MARK: - Variable
    var titlelabelarray = [UILabel]()
    var contentlabelarray = [UILabel]()
    var titletextarray: [String] = [" 1. Giới Thiệu:", " 2. Cán Sự Lớp:", " 3. Vị Trí:", " 4. Điểm Lớp:"]
    var isUserAClassStaff: Bool?
    var originalClassIntroductionText: String!
    
    var firstcontenttext: String!
    var seccondcontenttext: [String]!
    var thirdcontenttext: String!
    var fourthcontenttext: Int!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        viewConfig()
        AcceptAndDeclineButtonConfig()
    }

    private func viewConfig() {
        self.view.backgroundColor = .clear
        scrollView.backgroundColor = .clear
        scrollViewContainer.backgroundColor = .clear
        
        titlelabelarray.append(contentsOf: [FirstTitleLabel, SeccondTitleLabel, ThirdTitleLabel, FourthTitleLabel])
        
        contentlabelarray.append(contentsOf: [SeccondContentLabel, ThirdContentLabel, FourthContentLabel])
        
        for (i, v) in titlelabelarray.enumerated() {
            v.textColor = UIColor().MainTextColor(alpha: 1)
            v.font = UIFont.systemFont(ofSize: 22, weight: .medium)
            v.text = titletextarray[i]
        }
        
        for val in contentlabelarray {
            val.textColor = UIColor().SubTextColor(alpha: 1)
            val.numberOfLines = 0
            val.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        }
        
        SeccondContentLabel.text = """
            • Giáo Viên Chủ Nhiệm: \(seccondcontenttext[0])
            • Sĩ Số: \(seccondcontenttext[1])
            • Lớp Trưởng: \(seccondcontenttext[2])
            • Lớp Phó Học Tập: \(seccondcontenttext[3])
            • Lớp Phó Kỉ Luật: \(seccondcontenttext[4])
            • Bí Thư: \(seccondcontenttext[5])
            """
        ThirdContentLabel.text = thirdcontenttext
        FourthContentLabel.text = "\(fourthcontenttext!) điểm thi đua"
        
        FirstTextView.translatesAutoresizingMaskIntoConstraints = false
        FirstTextView.backgroundColor = .clear
        FirstTextView.isEditable = true
        FirstTextView.text = firstcontenttext
        FirstTextView.textColor = UIColor().SubTextColor(alpha: 1)
        FirstTextView.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        FirstTextView.delegate = self
        TextViewHeightConstraint.constant = FirstTextView.contentSize.height
        
    }
    
    private func AcceptAndDeclineButtonConfig() {
        let ButtonImageConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .medium, scale: .medium)
        AcceptChangeButton.setImage(UIImage(systemName: "checkmark", withConfiguration: ButtonImageConfig), for: .normal)
        AcceptChangeButton.tintColor = UIColor(red: 0.02, green: 0.81, blue: 0.19, alpha: 1.00)
        AcceptChangeButton.backgroundColor = UIColor(red: 0.12, green: 0.55, blue: 0.27, alpha: 1.00)
        AcceptChangeButton.layer.borderWidth = 1
        AcceptChangeButton.layer.borderColor = UIColor().BorderColor().cgColor
        AcceptChangeButton.layer.cornerRadius = 3
        AcceptChangeButton.setTitle(nil, for: .normal)
        AcceptChangeButton.isHidden = true
        
        
        DeclineChangeButton.setImage(UIImage(systemName: "xmark", withConfiguration: ButtonImageConfig), for: .normal)
        DeclineChangeButton.tintColor = UIColor(red: 0.62, green: 0.19, blue: 0.19, alpha: 1.00)
        DeclineChangeButton.backgroundColor = UIColor(red: 0.12, green: 0.55, blue: 0.27, alpha: 1.00)
        DeclineChangeButton.layer.borderWidth = 1
        DeclineChangeButton.layer.borderColor = UIColor().BorderColor().cgColor
        DeclineChangeButton.layer.cornerRadius = 3
        DeclineChangeButton.setTitle(nil, for: .normal)
        DeclineChangeButton.isHidden = true
    }
    
    //MARK: - DidTap
    @IBAction func AcceptButtonDidTap(_ sender: Any) {
        FirstTextView.resignFirstResponder()
        DeclineChangeButton.isHidden = true
        AcceptChangeButton.isHidden = true
    }
    
    @IBAction func DeclineButtonDidTap(_ sender: Any) {
        FirstTextView.text = originalClassIntroductionText
        FirstTextView.resignFirstResponder()
        DeclineChangeButton.isHidden = true
        AcceptChangeButton.isHidden = true
    }
}

//MARK: - TextViewDelegate
extension ClassMainInfoScreenViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        TextViewHeightConstraint.constant = FirstTextView.contentSize.height
        FirstTextView.layoutIfNeeded()
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        guard let staff = isUserAClassStaff, staff == true else {
            print("cant")
            return false
        }
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        originalClassIntroductionText = textView.text
        AcceptChangeButton.isHidden = false
        DeclineChangeButton.isHidden = false
    }
}
