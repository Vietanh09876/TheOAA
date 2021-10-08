//
//  AchievementViewController.swift
//  TheOAA
//
//  Created by Nguyễn Việt Anh on 18/09/2021.
//

import UIKit
import Firebase
import ProgressHUD

class AchievementViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var FirstSectionButton: SectionButton!
    @IBOutlet weak var SeccondSectionButton: SectionButton!
    @IBOutlet weak var ThirdSectionButton: SectionButton!
    @IBOutlet weak var othertitleLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var achievementsTableView: UITableView!
    
    @IBOutlet weak var tableViewConstraintHeight: NSLayoutConstraint!
    
    
    //MARK: - Variables
    var achievementarray = [SubAchievement]()
    
    var userAccId: String!
    let db = Firestore.firestore()
    var userFirestoreDoc: CollectionReference!
    var listener: ListenerRegistration!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        viewConfig()
        
        tableviewConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        listener.remove()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableViewConstraintHeight.constant = achievementsTableView.contentSize.height
    }
    
    
    func viewConfig() {
        self.view.backgroundColor = .clear
        
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = false
        
        containerView.backgroundColor = .clear
        
        FirstSectionButton.setTitle("Nhiệm Vụ Đã Nhận/Giao", for: .normal)
        
        SeccondSectionButton.setTitle("Nhiệm Vụ Đã Hoàn Thành", for: .normal)
        
        ThirdSectionButton.setTitle("Thành Tựu", for: .normal)
        
        othertitleLabel.text = "Thành Tựu (Khác):"
        othertitleLabel.textColor = UIColor().MainTextColor(alpha: 1)
        othertitleLabel.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        
        addButton.setTitle("+", for: .normal)
        addButton.setTitleColor(UIColor().MainTextColor(alpha: 1), for: .normal)
        addButton.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .medium)
        
        ThirdSectionButton.addTarget(self, action: #selector(thirdButtonDidTap(_:)), for: .touchUpInside)
    }
    
    func tableviewConfig() {
        achievementsTableView.dataSource = self
        achievementsTableView.delegate = self

        achievementsTableView.backgroundColor = .clear
        achievementsTableView.separatorColor = UIColor().TableViewSeparatorColor()
        achievementsTableView.isScrollEnabled = false
        achievementsTableView.register(UINib(nibName: "AchievementCell", bundle: nil), forCellReuseIdentifier: "AchievementCell")
    }
    
    //MARK: - Helpers
    
    func fetchData() {
        
        userFirestoreDoc = db.collection("users").document(userAccId).collection("subachievements")
        
        listener = userFirestoreDoc.addSnapshotListener {[weak self] document, error in
            guard let collection = document else {
                print("Error fetching document: \(error!)")
                return
            }
            self?.achievementarray = collection.documents.map({SubAchievement.init(SnapShot: $0)})
            
            self?.achievementsTableView.reloadData()
            self?.tableViewConstraintHeight.constant = self!.achievementsTableView.contentSize.height
        }
    }
    
    
    //MARK: - DidTap
    
    @IBAction func addButtonDidTap(_ sender: UIButton) {
        let AddVC = AddSubAchievementViewController()
        navigationController?.pushViewController(AddVC, animated: true)
        
    }
    
    @objc func thirdButtonDidTap(_ sender: UIButton) {
        let vc = MainAchievementListViewController()
        vc.userAccId = userAccId
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

extension AchievementViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return achievementarray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(withIdentifier: "AchievementCell", for: indexPath) as! AchievementCell
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = UIColor().CellSelectedBackgroundColor()
        
        Cell.selectedBackgroundView = selectedBackgroundView
        Cell.nameLabel.text = achievementarray[indexPath.row].name
        
        return Cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let AddVC = AddSubAchievementViewController()
        AddVC.isSelectedFromCell = true
        AddVC.achievementiamgeurlstring = achievementarray[indexPath.row].imageurl
        AddVC.name = achievementarray[indexPath.row].name
        AddVC.descriptiontext = """
\(achievementarray[indexPath.row].description)

Phần Thưởng:
\(achievementarray[indexPath.row].reward)
"""
        AddVC.id = achievementarray[indexPath.row].id
        navigationController?.pushViewController(AddVC, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
