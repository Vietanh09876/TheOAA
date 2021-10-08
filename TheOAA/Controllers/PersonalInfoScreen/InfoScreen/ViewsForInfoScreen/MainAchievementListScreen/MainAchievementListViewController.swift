//
//  MainAchievementListViewController.swift
//  TheOAA
//
//  Created by Nguyễn Việt Anh on 21/09/2021.
//

import UIKit
import Firebase

class MainAchievementListViewController: UIViewController {

    //MARK: - Outlet
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var CustomNavigationBar: CustomNavigationBar!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Variable
    var userAccId: String!
    var achievementarray = [MainAchievement]()
    
    let db = Firestore.firestore()
    var userFirestoreDoc: CollectionReference!
    var listener: ListenerRegistration!
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewConfig()
        
        tableViewConfig()
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
        CustomNavigationBar.titleLabel.text = "Thành Tựu"
        CustomNavigationBar.backButton.addTarget(self, action: #selector(backButtonDidTap(_:)), for: .touchUpInside)
    
    }
    
    func tableViewConfig() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.backgroundColor = .clear
        tableView.register(UINib(nibName: "MainAchievementCell", bundle: nil), forCellReuseIdentifier: "MainAchievementCell")
        
    }
    
    //MARK: - Helper
    
    func fetchData() {
        userFirestoreDoc = db.collection("users").document(userAccId).collection("mainachievements")
        
        listener = userFirestoreDoc.addSnapshotListener {[weak self] document, error in
            guard let collection = document else {
                print("Error fetching document: \(error!)")
                return
            }
            self?.achievementarray = collection.documents.map({MainAchievement.init(SnapShot: $0)})
            
            self?.tableView.reloadData()
            
        }
    }
    
    func downloadImageForCell(cell: MainAchievementCell, section: Int) {
        DispatchQueue.global().async {
            guard let photourl = URL(string: self.achievementarray[section].imageurl) ,let data = try? Data.init(contentsOf: photourl)  else {
                return
            }
            let downloadedimage = UIImage.init(data: data)
            
            DispatchQueue.main.async {
                cell.achievementImage.image = downloadedimage
            }
        }
    }
    //MARK: - DidTap
    @objc func backButtonDidTap(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        
    }
}

//MARK: - UITableViewDataSource, Delegate
extension MainAchievementListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return achievementarray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(withIdentifier: "MainAchievementCell", for: indexPath) as! MainAchievementCell
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = UIColor().CellSelectedBackgroundColor()
        
        Cell.selectedBackgroundView = selectedBackgroundView
        Cell.nameLabel.text = achievementarray[indexPath.section].name
        Cell.summarizeLabel.text = achievementarray[indexPath.section].description
        Cell.dateLabel.text = "- Thời Gian: \(achievementarray[indexPath.section].date)"
        Cell.rewardLabel.text = "- Phần Thưởng: \(achievementarray[indexPath.section].reward)"
        Cell.idLabel.text = "#\(achievementarray[indexPath.section].id)"
        
        return Cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return " "
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        view.tintColor = .clear
        view.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AddSubAchievementViewController()
        vc.isSelectedFromCell = true
        vc.name = achievementarray[indexPath.section].name
        vc.descriptiontext = """
\(achievementarray[indexPath.section].description)

- Thời Gian:
\(achievementarray[indexPath.section].date)

- Phần Thưởng:
\(achievementarray[indexPath.section].reward)
"""
        vc.id = achievementarray[indexPath.section].id
        vc.achievementiamgeurlstring = achievementarray[indexPath.section].imageurl
        vc.mynavigationbarTitle = "Thành Tựu"
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
