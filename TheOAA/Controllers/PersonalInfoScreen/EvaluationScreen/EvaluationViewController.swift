//
//  EvaluationViewController.swift
//  TheOAA
//
//  Created by Nguyễn Việt Anh on 15/09/2021.
//

import UIKit

class EvaluationViewController: UIViewController {
    
    
    //MARK: - Outlet
    @IBOutlet weak var schoolnameLabel: UILabel!
    @IBOutlet weak var maininfoLabel: UILabel!
    @IBOutlet weak var pictureframeImage: UIImageView!
    @IBOutlet weak var evaluationtitleLabel: UILabel!
    @IBOutlet weak var userpictureImage: UIImageView!
    @IBOutlet weak var scoreTableView: UITableView!
    @IBOutlet weak var teachernotestitleLabel: UILabel!
    @IBOutlet weak var teachernotesTextView: UITextView!
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var ScrollContainerView: UIView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var TeacherTextViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var AcceptChangeButton: UIButton!
    @IBOutlet weak var DeclineChangeButton: UIButton!
    @IBOutlet weak var moreinfoButton: UIButton!
    
    //MARK: - Variable
    var user: Student!
    var scorearray = [Float]()
    var ratedscorearray = [String]()
    var attributelabelArray = ["Học lực", "Thể chất", "Tư duy", "Đóng góp", "Tổng quát", "Tín nhiệm"]
    var previousscoreArray = [Float]()
    var originalTeacherNoteText: String!
    
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewConfig()
        AcceptAndDeclineButtonConfig()
        tableviewConfig()
        reloadData()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scoreTableView.layoutIfNeeded()
        tableViewHeightConstraint.constant = scoreTableView.contentSize.height
        
        teachernotesTextView.layoutIfNeeded()
        TeacherTextViewHeightConstraint.constant = teachernotesTextView.contentSize.height
    }
    
    private func viewConfig() {
        
        self.view.backgroundColor = .clear
        
        ScrollView.showsVerticalScrollIndicator = false
        ScrollView.delaysContentTouches = false
        
        ScrollContainerView.backgroundColor = .clear
        
        schoolnameLabel.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        schoolnameLabel.textColor = UIColor().MainTextColor(alpha: 1)
        schoolnameLabel.textAlignment = .left
        
        maininfoLabel.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        maininfoLabel.textColor = UIColor().MainTextColor(alpha: 1)
        maininfoLabel.numberOfLines = 0
        maininfoLabel.sizeToFit()
        
        pictureframeImage.image = UIImage(named: "im_PictureFrame")
        pictureframeImage.contentMode = .scaleToFill
        
        userpictureImage.loadImageFromCacheWithUrlstring(urlstring: user.avatarimageurl)
        userpictureImage.contentMode = .scaleAspectFill
        
        evaluationtitleLabel.text = "Đánh Giá:"
        evaluationtitleLabel.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        evaluationtitleLabel.textColor = UIColor().MainTextColor(alpha: 1)
        evaluationtitleLabel.textAlignment = .left
        evaluationtitleLabel.sizeToFit()
        
        teachernotestitleLabel.text = "Nhận Xét Của Giáo Viên:"
        teachernotestitleLabel.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        teachernotestitleLabel.textColor = UIColor().MainTextColor(alpha: 1)
        teachernotestitleLabel.textAlignment = .left
        teachernotestitleLabel.sizeToFit()
        
        
        teachernotesTextView.isScrollEnabled = true
        teachernotesTextView.textColor = UIColor().SubTextColor(alpha: 1)
        teachernotesTextView.backgroundColor = .white
        teachernotesTextView.layer.borderWidth = 1.5
        teachernotesTextView.layer.borderColor = UIColor().BorderColor().cgColor
        teachernotesTextView.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        teachernotesTextView.addDoneButtonOnKeyboard()
        teachernotesTextView.delegate = self
        
        let moreinfoButtonImageConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .default)
        moreinfoButton.setImage(UIImage(systemName: "info.circle", withConfiguration: moreinfoButtonImageConfig), for: .normal)
        moreinfoButton.tintColor = UIColor().MainTextColor(alpha: 1)
        moreinfoButton.setTitle(nil, for: .normal)
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
    
    private func tableviewConfig() {
        scoreTableView.dataSource = self
        scoreTableView.delegate = self
        scoreTableView.backgroundColor = .clear
        scoreTableView.separatorColor = .clear
        scoreTableView.showsVerticalScrollIndicator = false
        scoreTableView.register(UINib(nibName: "EvaluationComponentCell", bundle: nil), forCellReuseIdentifier: "EvaluationCell")
    }
    
    //MARK: - Helper
    func downloadPhotoForAvatar(urlstring: String) {
        DispatchQueue.global().async {
            guard let photourl = URL(string: urlstring) ,let data = try? Data.init(contentsOf: photourl)  else {return}
            let downloadedimage = UIImage.init(data: data)
            DispatchQueue.main.async {
                self.userpictureImage.image = downloadedimage
            }
        }
    }
    
    func reloadData() {
        schoolnameLabel.text = user.schoolname
        
        maininfoLabel.text = """
            Họ Và Tên: \(user.name!)
            
            Lớp: \(user.classname!)
            
            Mã Học Sinh: \(user.id!)
            """
        previousscoreArray = user.previousscore
        scorearray = [user.academicability, user.physicalability, user.adaptability, user.socialcontribution, user.OverallScore(), user.reliability]
        ratedscorearray = rateScore()
        
        scoreTableView.reloadData()
    }
    
    func rateScore() -> [String] {
        var ratedarray = [String]()
        
        for val in scorearray {
            switch val {
            case 95.5...100:
                ratedarray.append("A+ (\(Int(val)))")
            case 85.5..<95.5:
                ratedarray.append("A (\(Int(val)))")
            case 80.5..<85.5:
                ratedarray.append("A- (\(Int(val)))")
            case 75.5..<80.5:
                ratedarray.append("B+ (\(Int(val)))")
            case 65.5..<75.5:
                ratedarray.append("B (\(Int(val)))")
            case 60.5..<65.5:
                ratedarray.append("B- (\(Int(val)))")
            case 55.5..<60.5:
                ratedarray.append("C+ (\(Int(val)))")
            case 45.5..<55.5:
                ratedarray.append("C (\(Int(val)))")
            case 40.5..<45.5:
                ratedarray.append("C- (\(Int(val)))")
            case 35.5..<40.5:
                ratedarray.append("D+ (\(Int(val)))")
            case 25.5..<35.5:
                ratedarray.append("D (\(Int(val)))")
            case 20.5..<25.5:
                ratedarray.append("D- (\(Int(val)))")
            case 15.5..<20.5:
                ratedarray.append("E+ (\(Int(val)))")
            case 5.5..<15.5:
                ratedarray.append("E (\(Int(val)))")
            case 0.5..<5.5:
                ratedarray.append("E- (\(Int(val)))")
            case 0..<0.5:
                ratedarray.append("F (\(Int(val)))")
            default:
                ratedarray.append(" ")
            }
        }
        return ratedarray
    }
    
    //MARK: - DidTap
    @IBAction func AcceptButtonDidTap(_ sender: Any) {
        teachernotesTextView.resignFirstResponder()
        DeclineChangeButton.isHidden = true
        AcceptChangeButton.isHidden = true
    }
    
    @IBAction func DeclineButtonDidTap(_ sender: Any) {
        teachernotesTextView.text = originalTeacherNoteText
        teachernotesTextView.resignFirstResponder()
        DeclineChangeButton.isHidden = true
        AcceptChangeButton.isHidden = true
    }
    @IBAction func moreinfoButtonDidTap(_ sender: Any) {
        let moreinfoVC = MoreEvaluationInfoViewController()
        moreinfoVC.previousscorearray = user.previousscore
        moreinfoVC.scorearray = scorearray
        moreinfoVC.ratedscorearray = rateScore()
        
        present(moreinfoVC, animated: true, completion: nil)
    }
    
}


    //MARK: - TableViewDataSource, Delegate
extension EvaluationViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return scorearray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(withIdentifier: "EvaluationCell", for: indexPath) as! EvaluationComponentCell
        Cell.selectionStyle = .none
        Cell.label.font = UIFont.systemFont(ofSize: 22, weight: .medium)

        if indexPath.section == 4 {
            Cell.label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        }
        
        Cell.label.text = "\(attributelabelArray[indexPath.section]): \(ratedscorearray[indexPath.section])"
        
        if indexPath.section == 5 {
            Cell.label.text = "\(attributelabelArray[indexPath.section]): \(Int(scorearray[indexPath.section]))"
        }
        
        if scorearray[indexPath.section] >= previousscoreArray[indexPath.section] {
            Cell.imageview.image = UIImage(named: "ic_UpArrow")
        }
        else {
            Cell.imageview.image = UIImage(named: "ic_DownArrow")
        }
        
        return Cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .clear
        view.isHidden = true
    }
}


//MARK: - TextViewDelegate
extension EvaluationViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        TeacherTextViewHeightConstraint.constant = teachernotesTextView.contentSize.height
        teachernotesTextView.layoutIfNeeded()
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return false
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        originalTeacherNoteText = textView.text
        AcceptChangeButton.isHidden = false
        DeclineChangeButton.isHidden = false
    }
}
