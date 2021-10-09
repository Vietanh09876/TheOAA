//
//  ClassInfoViewController.swift
//  TheOAA
//
//  Created by Nguyễn Việt Anh on 19/09/2021.
//

import UIKit
import Firebase
import ProgressHUD

class ClassInfoViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var CustomNavigationBar: CustomNavigationBar!
    @IBOutlet weak var CustomTabbar: CustomTabBar!
    @IBOutlet weak var containerForChildView: UIView!
    
    
    //MARK: - Variable
    var classroom: ClassRoom!
    let ClassMainInfoScreen = ClassMainInfoScreenViewController()
    let StudentsListScreen = StudentsListViewController()
    let TeachersListScreen = TeachersListViewController()
    var ChildScreenIsOn: Int!
    
    let choiceAlert1 = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    let scorechoiceAlert1 = UIAlertController(title: nil, message: "Theo Năng Lực", preferredStyle: .actionSheet)
    let patternAlert1 = UIAlertController(title: nil, message: "Trình Tự", preferredStyle: .actionSheet)
    let choiceAlert2 = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

    
    var SortingChoiceNumber: Int!
    var studentslist = [Student]()
    let db = Firestore.firestore()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        passData()
        
        viewConfig()
        
        CustomTabbar.pressedbuttonindex = {[weak self] x in
            self?.removeChildView()
            self?.addChildScreen(screennumber: x)
            self?.ChildScreenIsOn = x
            self?.BackButtonChangeBackground()
        }
        
        CustomTabbar.ButtonDidTap(CustomTabbar.LeftButton)
        sortingForStudentListAlertController()
        sortingForTeacherListAlertController()
    }
    
    private func viewConfig() {
        containerView.backgroundColor = UIColor().ContainerViewColor()
        backgroundImage.image = UIImage(named: "im_BackgroundDecoBott")
        backgroundImage.contentMode = .scaleAspectFill
        
        containerForChildView.backgroundColor = .clear
        
        CustomNavigationBar.backgroundColor = .clear
        CustomNavigationBar.titleLabel.text = classroom.classname
        CustomNavigationBar.backButton.addTarget(self, action: #selector(BackButtonDidTap(_:)), for: .touchUpInside)
        
        CustomTabbar.LeftButton.setTitle("Thông Tin", for: .normal)
        CustomTabbar.MiddleButton.setTitle("Học Sinh", for: .normal)
        CustomTabbar.RightButton.setTitle("Giáo Viên", for: .normal)
        
        
    }
    
    func sortingForStudentListAlertController() {
        let alertActionSortName = UIAlertAction(title: "Tên (A-Z)", style: .default) {[weak self] _ in
            switch self?.ChildScreenIsOn {
            case 2:
                self?.StudentsListScreen.sortedList = self!.SortByAlphabet(array: self!.studentslist)
                
            case 3:
                self?.TeachersListScreen.choosensortingoptionLabel.text = "Sorted by: name"
            default:
                return
            }
        }
        
        let alertActionSortAbility = UIAlertAction(title: "Điểm Năng Lực", style: .default) {[weak self] _ in
            self?.present(self!.scorechoiceAlert1, animated: true, completion: nil)
        }
        
        //MARK: scorechoiceAlert
        let alertActionSortAcademic = UIAlertAction(title: "Học Lực", style: .default) {[weak self] _ in
            self?.SortingChoiceNumber = 1
            self?.present(self!.patternAlert1, animated: true, completion: nil)
        }
        
        let alertActionSortAdaptibility = UIAlertAction(title: "Tư Duy", style: .default) {[weak self] _ in
            self?.SortingChoiceNumber = 2
            self?.present(self!.patternAlert1, animated: true, completion: nil)
        }
        
        let alertActionSortPhysical = UIAlertAction(title: "Thể Chất", style: .default) {[weak self] _ in
            self?.SortingChoiceNumber = 3
            self?.present(self!.patternAlert1, animated: true, completion: nil)
        }
        
        let alertActionSortSocial = UIAlertAction(title: "Đóng Góp Cộng Đồng", style: .default) {[weak self] _ in
            self?.SortingChoiceNumber = 4
            self?.present(self!.patternAlert1, animated: true, completion: nil)
        }
        
        let alertActionSortTrust = UIAlertAction(title: "Độ Tín Nhiệm", style: .default) {[weak self] _ in
            self?.SortingChoiceNumber = 5
            self?.present(self!.patternAlert1, animated: true, completion: nil)
        }
        
        let alertActionSortOverall = UIAlertAction(title: "Tổng", style: .default) {[weak self] _ in
            self?.SortingChoiceNumber = 6
            self?.present(self!.patternAlert1, animated: true, completion: nil)
        }
        
        //MARK: patternAlert
        let alertActionSortHighToLow = UIAlertAction(title: "Cao Đến Thấp", style: .default) {[weak self] _ in
            self?.Sorting(isHightoLow: true)
        }
        
        let alertActionSortLowToHigh = UIAlertAction(title: "Thấp Đến Cao", style: .default) {[weak self] _ in
            self?.Sorting(isHightoLow: false)
        }
        
        //MARK: Cancelalert
        let alertActionCancel1 = UIAlertAction(title: "Hủy", style: .cancel) { _ in
        }
        
        let alertActionCancel2 = UIAlertAction(title: "Hủy", style: .cancel) { _ in
        }
        
        let alertActionCancel3 = UIAlertAction(title: "Hủy", style: .cancel) { _ in
        }
        
        
        choiceAlert1.addAction(alertActionCancel1)
        choiceAlert1.addAction(alertActionSortName)
        choiceAlert1.addAction(alertActionSortAbility)
        
        scorechoiceAlert1.addAction(alertActionCancel2)
        scorechoiceAlert1.addAction(alertActionSortAcademic)
        scorechoiceAlert1.addAction(alertActionSortAdaptibility)
        scorechoiceAlert1.addAction(alertActionSortPhysical)
        scorechoiceAlert1.addAction(alertActionSortSocial)
        scorechoiceAlert1.addAction(alertActionSortTrust)
        scorechoiceAlert1.addAction(alertActionSortOverall)
        
        patternAlert1.addAction(alertActionCancel3)
        patternAlert1.addAction(alertActionSortHighToLow)
        patternAlert1.addAction(alertActionSortLowToHigh)
        
    }
    
    func sortingForTeacherListAlertController() {
        let alertActionCancel = UIAlertAction(title: "Hủy", style: .cancel) { _ in
        }
        
        let alertActionSortName = UIAlertAction(title: "Tên (A-Z)", style: .default) {[weak self] _ in
            self?.TeachersListScreen.choosensortingoptionLabel.text = "Sorted by: name"
        }
        
        choiceAlert2.addAction(alertActionCancel)
        choiceAlert2.addAction(alertActionSortName)
    }
    
    //MARK: - Helper
    func passData() {
        ClassMainInfoScreen.firstcontenttext = classroom.introduction
        ClassMainInfoScreen.seccondcontenttext = classroom.classstaff
        ClassMainInfoScreen.thirdcontenttext = classroom.location
        ClassMainInfoScreen.fourthcontenttext = classroom.classpoint
        ClassMainInfoScreen.classroom = classroom
        
        fetchDataForStudentList()
    }
    
    func fetchDataForStudentList() {
        if classroom.studentlist.isEmpty {
            return
        }
        else {
            for val in classroom.studentlist {
                db.collection("users").document(val).getDocument {[weak self] document, error in
                    guard let data = document, error == nil else {
                        return
                    }
                    let name = data["name"] as! String
                    let id = data["id"] as! String
                    let classname = data["classname"] as! String
                    let classrole = data["classrole"] as! String
                    let academic = data["academicability"] as! Float
                    let physical = data["physicalability"] as! Float
                    let adapt = data["adaptability"] as! Float
                    let social = data["socialcontribution"] as! Float
                    let reli = data["reliability"] as! Float
                    
                    let student = Student(name: name, id: id, useraccuid: data.documentID, classname: classname, classrole: classrole, academic: academic, physical: physical, adapt: adapt, social: social, reli: reli)
                    self?.studentslist.append(student)
                    self?.StudentsListScreen.sortedList.append(student)
                }
            }
        }
    }
    
    func addChildScreen(screennumber: Int) {
        removeChildView()
        
        switch screennumber {
        case 1:
            self.containerForChildView.addSubview(ClassMainInfoScreen.view)
            self.addChild(ClassMainInfoScreen)
            ClassMainInfoScreen.view.fitSuperviewConstraint()
        case 2:
            self.containerForChildView.addSubview(StudentsListScreen.view)
            self.addChild(StudentsListScreen)
            StudentsListScreen.view.fitSuperviewConstraint()
            StudentsListScreen.sortedList = SortByAlphabet(array: studentslist)
        case 3:
            self.containerForChildView.addSubview(TeachersListScreen.view)
            self.addChild(TeachersListScreen)
            TeachersListScreen.view.fitSuperviewConstraint()
        default:
            return
        }
        
    }
    
    
    func removeChildView() {
        switch ChildScreenIsOn {
        case 1:
            ClassMainInfoScreen.view.removeFromSuperview()
            ClassMainInfoScreen.removeFromParent()
        case 2:
            StudentsListScreen.view.removeFromSuperview()
            StudentsListScreen.removeFromParent()
        case 3:
            TeachersListScreen.view.removeFromSuperview()
            TeachersListScreen.removeFromParent()
        default:
            return
        }
    }
    
    func BackButtonChangeBackground() {
        if ChildScreenIsOn != 1 {
            CustomNavigationBar.backButton.setImage(UIImage(named: "ic_Filter")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), for: .normal)
        }
        else {
            CustomNavigationBar.backButton.setImage(UIImage(named: "ic_BackButton")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), for: .normal)
        }
    }
    
    
    func Sorting(isHightoLow: Bool) {
        if ChildScreenIsOn == 2 {
            switch SortingChoiceNumber {
            case 1:
                StudentsListScreen.sortedList = (studentslist.sorted(by: { user1, user2 in
                    return isHightoLow ? user1.academicability > user2.academicability : user1.academicability < user2.academicability
                }))
                StudentsListScreen.choosensortingoptionLabel.text = isHightoLow ? "Sorted by: academicability(High to low)" : "Sorted by: academicability(Low to high)"
                StudentsListScreen.tableView.reloadData()
            case 2:
                StudentsListScreen.sortedList = (studentslist.sorted(by: { user1, user2 in
                    return isHightoLow ? user1.adaptability > user2.adaptability : user1.adaptability < user2.adaptability
                }))
                StudentsListScreen.choosensortingoptionLabel.text = isHightoLow ? "Sorted by: adaptability(High to low)" : "Sorted by: adaptability(Low to high)"
                StudentsListScreen.tableView.reloadData()
            case 3:
                StudentsListScreen.sortedList = (studentslist.sorted(by: { user1, user2 in
                    return isHightoLow ? user1.physicalability > user2.physicalability : user1.physicalability < user2.physicalability
                }))
                StudentsListScreen.choosensortingoptionLabel.text = isHightoLow ? "Sorted by: physicalability(High to low)" : "Sorted by: physicalability(Low to high)"
                StudentsListScreen.tableView.reloadData()
            case 4:
                StudentsListScreen.sortedList = (studentslist.sorted(by: { user1, user2 in
                    return isHightoLow ? user1.socialcontribution > user2.socialcontribution : user1.socialcontribution < user2.socialcontribution
                }))
                StudentsListScreen.choosensortingoptionLabel.text = isHightoLow ? "Sorted by: socialcontribution(High to low)" : "Sorted by: socialcontribution(Low to high)"
                StudentsListScreen.tableView.reloadData()
            case 5:
                StudentsListScreen.sortedList = (studentslist.sorted(by: { user1, user2 in
                    return isHightoLow ? user1.reliability > user2.reliability : user1.reliability < user2.reliability
                }))
                StudentsListScreen.choosensortingoptionLabel.text = isHightoLow ? "Sorted by: reliability(High to low)" : "Sorted by: reliability(Low to high)"
                StudentsListScreen.tableView.reloadData()
            case 6:
                StudentsListScreen.sortedList = (studentslist.sorted(by: { user1, user2 in
                    return isHightoLow ? user1.OverallScore() > user2.OverallScore() : user1.OverallScore() < user2.OverallScore()
                }))
                StudentsListScreen.choosensortingoptionLabel.text = isHightoLow ? "Sorted by: Overall Score(High to low)" : "Sorted by: Overall Score(Low to high)"
                StudentsListScreen.tableView.reloadData()
            default:
                return
            }
        }
        else {
            return
        }
        
    }
    
    func SortByAlphabet(array: [Student]) -> [Student] {
        let sortedarray = array.sorted { name1, name2 in
            let seperatedname1 = name1.name.components(separatedBy: " ")
            let seperatedname2 = name2.name.components(separatedBy: " ")
            let name1last = seperatedname1.last!
            let name2last = seperatedname2.last!
            let name1totalIndices = seperatedname1.count - 1
            let name2totalIndices = seperatedname2.count - 1
            var result: Bool!
                        
            if name1last == name2last {
                if seperatedname1.count > seperatedname2.count {
                    for num in 1...seperatedname2.count-1 {
                        if seperatedname1[name1totalIndices - num] != seperatedname2[name2totalIndices - num] {
                            result = seperatedname1[name1totalIndices - num].localizedCaseInsensitiveCompare(seperatedname2[name2totalIndices - num]) == .orderedAscending
                            break
                        }
                        else {
                            result = seperatedname1.first!.localizedCaseInsensitiveCompare(seperatedname2.first!) == .orderedAscending
                        }
                    }
                    return result
                }
                else {
                    for num in 1...seperatedname1.count-1 {
                        if seperatedname1[name1totalIndices - num] != seperatedname2[name2totalIndices - num] {
                            result = seperatedname1[name1totalIndices - num].localizedCaseInsensitiveCompare(seperatedname2[name2totalIndices - num]) == .orderedAscending
                            break
                        }
                        else {
                            result = seperatedname1.first!.localizedCaseInsensitiveCompare(seperatedname2.first!) == .orderedAscending
                        }
                    }
                    return result
                }
            }
            else {
                result = name1last.localizedCaseInsensitiveCompare(name2last) == .orderedAscending
                return result
            }
        }
        
        StudentsListScreen.choosensortingoptionLabel.text = "Sorted by: name"
        StudentsListScreen.tableView.reloadData()
        return sortedarray
    }
    
    //MARK: - DidTap
    @objc func BackButtonDidTap(_ sender: UIButton) {
        switch ChildScreenIsOn {
        case 1:
            navigationController?.popViewController(animated: true)
        case 2:
            present(choiceAlert1, animated: true, completion: nil)
        case 3:
            present(choiceAlert2, animated: true, completion: nil)
        default:
            return
        }
    }
}
