//
//  ClassListViewController.swift
//  TheOAA
//
//  Created by Nguyễn Việt Anh on 08/09/2021.
//

import UIKit
import Firebase

class ClassListViewController: UIViewController {
    
    //MARK: - Outlet
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var AvatarFrameView: AvatarFrameView!
    @IBOutlet weak var notifiButton: NotificationButton!
    @IBOutlet weak var settingButton: SettingButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollContainerView: UIView!
    @IBOutlet weak var scrollContainerViewHeightConstraint: NSLayoutConstraint!
    
    //MARK: - Variable
    var user: Student!
    var listTableView = UITableView(frame: CGRect.zero)
    var buttonHeightConstraint = [NSLayoutConstraint]()
    var gradesarray = [String]()
    var classarray = [[ClassRoom]]()
    var reversedclassarry = [[ClassRoom]]()
    var userclassrom: ClassRoom?
    var Sectionpressed: Int = 0
    var sectionsarray = [SectionButton]()
    var isSectionOpened = [Bool]()
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        reversedclassarry = classarray.reversed()
        
        viewConfig()
        
        CreateSectionButton()
        
        setupSectionLayout()
        
        tableViewConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AvatarFrameView.fetchData()
    }
    
    private func viewConfig() {
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        scrollView.delaysContentTouches = false
        
        scrollContainerView.backgroundColor = .clear
        scrollContainerView.isUserInteractionEnabled = true
        scrollContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.backgroundColor = UIColor().ContainerViewColor()
        
        backgroundImage.image = UIImage(named: "im_BackgroundDeco")
        backgroundImage.contentMode = .scaleAspectFill
        
        
        AvatarFrameView.backgroundColor = .clear
        
        AvatarFrameView.nameIdTapGesture.addTarget(self, action: #selector(NameIdLabelDidTap(_:)))
        
        settingButton.addTarget(self, action: #selector(settingButtonDidTap(_ :)), for: .touchUpInside)
    }
    
    
    private func tableViewConfig() {
        listTableView.dataSource = self
        listTableView.delegate = self
        listTableView.backgroundColor = .clear
        listTableView.separatorColor = UIColor().TableViewSeparatorColor()
        listTableView.separatorInset.left = 0
        listTableView.translatesAutoresizingMaskIntoConstraints = false
        
        
    }
    
    private func tablevViewSetupLayout(section: UIButton) {
        scrollContainerView.addSubview(listTableView)
        scrollContainerView.bringSubviewToFront(listTableView)
        
        listTableView.topAnchor.constraint(equalTo: section.topAnchor, constant: 55).isActive = true
        listTableView.leadingAnchor.constraint(equalTo: section.leadingAnchor).isActive = true
        listTableView.trailingAnchor.constraint(equalTo: section.trailingAnchor).isActive = true
        listTableView.bottomAnchor.constraint(equalTo: section.bottomAnchor).isActive = true
        
        listTableView.reloadData()
    }
    
    func CreateSectionButton() {
        for (index, value) in gradesarray.enumerated() {
            let sectionbutton: SectionButton = {
                let button = SectionButton(type: .system)
                button.setTitle(value, for: .normal)
                button.tag = index
                button.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .medium)
                button.addTarget(self, action: #selector(SectionButtonDidTap(_:)), for: .touchUpInside)
                button.translatesAutoresizingMaskIntoConstraints = false
                return button
            }()
            
            sectionsarray.append(sectionbutton)
            isSectionOpened.append(false)
            
        }
    }
    
    func setupSectionLayout() {
        for (index, val) in sectionsarray.enumerated() {
            scrollContainerView.addSubview(val)
            
            if index == 0 {
                val.topAnchor.constraint(equalTo: scrollContainerView.topAnchor, constant: 0).isActive = true
                val.leadingAnchor.constraint(equalTo: scrollContainerView.leadingAnchor, constant: 25).isActive = true
                val.trailingAnchor.constraint(equalTo: scrollContainerView.trailingAnchor, constant: -25).isActive = true
                
                let height = val.heightAnchor.constraint(equalToConstant: 55)
                buttonHeightConstraint.append(height)
                
            }
            else {
                val.topAnchor.constraint(equalTo: sectionsarray[index-1].bottomAnchor, constant: 35).isActive = true
                val.leadingAnchor.constraint(equalTo: scrollContainerView.leadingAnchor, constant: 25).isActive = true
                val.trailingAnchor.constraint(equalTo: scrollContainerView.trailingAnchor, constant: -25).isActive = true
                
                let height = val.heightAnchor.constraint(equalToConstant: 55)
                buttonHeightConstraint.append(height)
                
            }
        }
        
        NSLayoutConstraint.activate(buttonHeightConstraint)
        
        NSLayoutConstraint.deactivate([scrollContainerViewHeightConstraint])
        
        if let lastsection = sectionsarray.last {
            scrollContainerView.bottomAnchor.constraint(equalTo: lastsection.bottomAnchor, constant: 35).isActive = true
        } else {return}
        
    }
    
    //MARK: - Helper
    
    
    func OpenASection(sender: UIButton) {
        for (index, val) in isSectionOpened.enumerated() {
            if val == true {
                CloseASection(sender: sectionsarray[index])
            }
        }
        
        tablevViewSetupLayout(section: sender)
        
        isSectionOpened[sender.tag] = true
        sectionsarray[sender.tag].setBackgroundImage(UIImage(named: "im_OpenedSection"), for: .normal)
        sender.contentVerticalAlignment = .top
        sender.titleEdgeInsets.top = 14
        
        buttonHeightConstraint[sender.tag].constant = 315
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            sender.layoutIfNeeded()
            sender.center.y += sender.frame.height/2
        }, completion: nil)
    }
    
    func CloseASection(sender: UIButton) {
        isSectionOpened[sender.tag] = false
        
        listTableView.removeFromSuperview()
        
        sectionsarray[sender.tag].setBackgroundImage(UIImage(named: "im_Section"), for: .normal)
        sender.contentVerticalAlignment = .center
        sender.titleEdgeInsets.top = 0
        
        buttonHeightConstraint[sender.tag].constant = 55
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            sender.center.y -= sender.frame.height/2
            sender.layoutIfNeeded()
            
        }, completion: nil)
    }
    
    func checkIsUserAClassStaff() -> Bool {
        guard let staff = user.classrole, staff.isEmpty == false  else {
            return false
        }
        return true
    }
    //MARK: - DidTap
    
    @objc func NameIdLabelDidTap(_ sender: Any) {
        let personalVC = PersonalInfoViewController()
        personalVC.userAccId = Auth.auth().currentUser?.uid
        navigationController?.pushViewController(personalVC, animated: true)
    }
    
    @objc func settingButtonDidTap(_ sender: UIButton) {
        let settingVC = SettingViewController()
        navigationController?.pushViewController(settingVC, animated: true)
    }
    
    @objc func SectionButtonDidTap(_ sender: UIButton) {
        
        if sender.tag == 0 {
            Sectionpressed = sender.tag
            let classinfoVC = ClassInfoViewController()
            
            guard let userclassrom = userclassrom else {return}
            classinfoVC.classroom = userclassrom
            classinfoVC.ClassMainInfoScreen.isUserAClassStaff = checkIsUserAClassStaff()
            navigationController?.pushViewController(classinfoVC, animated: true)
        }
        else {
            Sectionpressed = sender.tag-1
            if isSectionOpened[sender.tag] == false {
                OpenASection(sender: sender)
            }
            else {
                CloseASection(sender: sender)
            }
        }
    }
}

//MARK: - Tableview Datasource, Delegate
extension ClassListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reversedclassarry[Sectionpressed].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = UITableViewCell()
        var config = Cell.defaultContentConfiguration()
        config.text = reversedclassarry[Sectionpressed][indexPath.row].classname
        config.textProperties.alignment = .center
        config.textProperties.color = UIColor().SubTextColor(alpha: 1)
        config.textProperties.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = UIColor().CellSelectedBackgroundColor()
        
        Cell.selectedBackgroundView = selectedBackgroundView
        Cell.backgroundColor = .clear
        Cell.contentConfiguration = config
        return Cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let classinfoVC = ClassInfoViewController()
        
        classinfoVC.classroom = reversedclassarry[Sectionpressed][indexPath.row]
        if reversedclassarry[Sectionpressed][indexPath.row].classname == user.classname {
            classinfoVC.ClassMainInfoScreen.isUserAClassStaff = checkIsUserAClassStaff()
        }
        
        navigationController?.pushViewController(classinfoVC, animated: true)
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
}
