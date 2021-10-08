//
//  StudentsListViewController.swift
//  TheOAA
//
//  Created by Nguyễn Việt Anh on 20/09/2021.
//

import UIKit

class StudentsListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var choosensortingoptionLabel: UILabel!
    
    var sortedList = [Student]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewConfig()
        
    }
    
    private func viewConfig() {
        self.view.backgroundColor = .clear
        
        tableView.backgroundColor = .clear
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.separatorColor = UIColor(red: 0.47, green: 0.72, blue: 0.38, alpha: 1.00)
        tableView.register(UINib(nibName: "MemberListCell", bundle: nil), forCellReuseIdentifier: "MemberListCell")
        
        backButton.setImage(UIImage(named: "ic_BottBackButton")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), for: .normal)
        backButton.setTitle(nil, for: .normal)
        backButton.addTarget(ClassInfoViewController(), action: #selector(BackButtonDidTap(_:)), for: .touchUpInside)
        
        choosensortingoptionLabel.textColor = UIColor().MainTextColor(alpha: 1)
        choosensortingoptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        choosensortingoptionLabel.text = "Sorted by: name"
    }
    
    @objc func BackButtonDidTap(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}

extension StudentsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(withIdentifier: "MemberListCell", for: indexPath) as! MemberListCell
        
        Cell.nameidLabel.text = """
\(sortedList[indexPath.row].name!) \(sortedList[indexPath.row].classrole!.isEmpty ? "" : "(\(sortedList[indexPath.row].classrole!))")
#\(sortedList[indexPath.row].id!)
"""
        
        Cell.selectionStyle = .none
        
        Cell.ordinalnumberLabel.text = "\(indexPath.row + 1)."
        
        return Cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let personalinfoVC = PersonalInfoViewController()
        personalinfoVC.userAccId = sortedList[indexPath.row].useraccuid
        navigationController?.pushViewController(personalinfoVC, animated: true)
    }
}
