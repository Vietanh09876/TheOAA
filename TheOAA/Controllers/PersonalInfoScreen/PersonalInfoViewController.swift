//
//  PersonalInfoViewController.swift
//  TheOAA
//
//  Created by Nguyễn Việt Anh on 14/09/2021.
//

import UIKit
import Firebase
import ProgressHUD

class PersonalInfoViewController: UIViewController {
    
    //MARK: - Outlet
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var CustomNavigationBar: CustomNavigationBar!
    @IBOutlet weak var CustomTabBar: CustomTabBar!
    @IBOutlet weak var ContainerForTableView: UIView!
    
    
    //MARK: - Variable
    var ChildViewIsOn: Int!
    let EvaluationScreen = EvaluationViewController()
    let ScoreboardScreen = ScoreboardScreenController()
    let InfoScreen = InfoViewController()
    
    var userAccId: String?
    let db = Firestore.firestore()
    var userFirestoreDoc: DocumentReference!
    var listener: ListenerRegistration!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewConfig()
        
        self.CustomTabBar.pressedbuttonindex = {[weak self] x in
            
            self?.addChildScreen(screennumber: x)
            self?.ChildViewIsOn = x
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        listener.remove()
    }
    
    
    private func viewConfig() {
        containerView.backgroundColor = UIColor().ContainerViewColor()
        backgroundImage.image = UIImage(named: "im_BackgroundDecoBott")
        backgroundImage.contentMode = .scaleAspectFill
        
        CustomNavigationBar.backgroundColor = .clear
        CustomNavigationBar.backButton.addTarget(self, action: #selector(backButtonDidTap(_:)), for: .touchUpInside)
        CustomNavigationBar.titleLabel.text = "Thông Tin"
        
        CustomTabBar.backgroundColor = .clear
        CustomTabBar.LeftButton.setTitle("Đánh Giá", for: .normal)
        CustomTabBar.MiddleButton.setTitle("Bảng Điểm", for: .normal)
        CustomTabBar.RightButton.setTitle("Cá Nhân", for: .normal)
        
        ContainerForTableView.backgroundColor = .clear
        
        
    }
    
    
    
    
    //MARK: - Helper
    
    func fetchData() {
        InfoScreen.achievementview.userAccId = userAccId
        ProgressHUD.show()
        guard let userAccId = userAccId else {
            return
        }
        
        userFirestoreDoc = db.collection("users").document(userAccId)
        
        listener = userFirestoreDoc.addSnapshotListener {[weak self] document, error in
            guard let document = document else {
                print("Error fetching document: \(error!)")
                self?.CustomTabBar.isHidden = true
                ProgressHUD.dismiss()
                return
            }
            guard let data = document.data() else {
                print("Document data was empty.")
                self?.CustomTabBar.isHidden = true
                ProgressHUD.dismiss()
                return
            }
            let name = data["name"] as! String
            let id = data["id"] as! String
            let schoolname = data["schoolname"] as! String
            let classname = data["classname"] as! String
            let avatarimageurl = data["avatarimageurl"] as! String
            let academic = data["academicability"] as! Float
            let physical = data["physicalability"] as! Float
            let adapt = data["adaptability"] as! Float
            let social = data["socialcontribution"] as! Float
            let reli = data["reliability"] as! Float
            let previousscore = data["previousscore"] as! [Float]
            let personalinfo = data["personalinfo"] as! [String]
            let guardianname = data["guardianname"] as! [String]
            let guardianphone = data["guardianphonenumber"] as! [String]
            
            self?.EvaluationScreen.user = Student(name: name, id: id, avatarimageurl: avatarimageurl, schoolname: schoolname, classname: classname, classrole: nil, academic: academic, physical: physical, adapt: adapt, social: social, reli: reli,previousscore: previousscore)
            
            self?.InfoScreen.avatarimageurl = avatarimageurl
            if self?.userAccId == Auth.auth().currentUser?.uid {
                self?.InfoScreen.myinfoview.personalinfo = [name]
                self?.InfoScreen.myinfoview.personalinfo.append(contentsOf: personalinfo)
            }
            self?.InfoScreen.communicationview.user = Student(personalinfo: personalinfo, guardianname: guardianname, guardianphone: guardianphone)
            
            switch self?.ChildViewIsOn {
            case 1:
                self?.EvaluationScreen.reloadData()
            case 2:
                print("listening to scoreboardscreen")
            case 3:
                self?.InfoScreen.userpictureImage.loadImageFromCacheWithUrlstring(urlstring: avatarimageurl)
                self?.EvaluationScreen.userpictureImage.loadImageFromCacheWithUrlstring(urlstring: avatarimageurl)
                if self?.InfoScreen.viewIsOn == 1 {
                    self?.InfoScreen.myinfoview.tableView.reloadData()
                }
                else if self?.InfoScreen.viewIsOn == 2 {
                    self?.InfoScreen.communicationview.tableView.reloadData()
                }
                else {
                    self?.InfoScreen.achievementview.achievementsTableView.reloadData()
                }
            default:
                self?.CustomTabBar.ButtonDidTap((self?.CustomTabBar.LeftButton)!)
            }
            ProgressHUD.dismiss()
        }
    }
    
    func addChildScreen(screennumber: Int) {
        removeChildView()
        
        switch screennumber {
        case 1:
            ContainerForTableView.addSubview(EvaluationScreen.view)
            self.addChild(EvaluationScreen)
            EvaluationScreen.view.fitSuperviewConstraint()
        case 2:
            ContainerForTableView.addSubview(ScoreboardScreen.view)
            self.addChild(ScoreboardScreen)
            ScoreboardScreen.view.fitSuperviewConstraint()
        case 3:
            ContainerForTableView.addSubview(InfoScreen.view)
            self.addChild(InfoScreen)
            InfoScreen.view.fitSuperviewConstraint()
        default:
            return
        }
    }

    func removeChildView() {
        switch ChildViewIsOn {
        case 1:
            self.EvaluationScreen.view.removeFromSuperview()
            self.EvaluationScreen.removeFromParent()
        case 2:
            self.ScoreboardScreen.view.removeFromSuperview()
            self.ScoreboardScreen.removeFromParent()
        case 3:
            self.InfoScreen.view.removeFromSuperview()
            self.InfoScreen.removeFromParent()
        default:
            return
        }
    }
    
    
    
    //MARK: - DidTap
    @objc func backButtonDidTap(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}



