//
//  CommunicationViewController.swift
//  TheOAA
//
//  Created by Nguyễn Việt Anh on 18/09/2021.
//

import UIKit

class CommunicationViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var user: Student!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewConfig()
    }
    
    
    func viewConfig() {
        self.view.backgroundColor = .clear
                
        tableViewConfig()
        
        
    }
    
    func tableViewConfig() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.backgroundColor = .clear
        tableView.separatorColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UINib(nibName: "CommunicationCell", bundle: nil), forCellReuseIdentifier: "CommunicationCell")
        
    }
    

}

extension CommunicationViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    //MARK: Header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "1. Phụ Huynh"
        case 1:
            return "2. Phụ Huynh"
        case 2:
            return "3. Giáo Viên Chủ Nhiệm"
        default:
            return "?"
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor(red: 0.12, green: 0.55, blue: 0.27, alpha: 1.00)
        
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = .white
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    //MARK: Footer
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        view.tintColor = .clear
        view.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 15
    }
    
    
    //MARK: Cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(withIdentifier: "CommunicationCell", for: indexPath) as! CommunicationCell
        
        Cell.selectionStyle = .none
        Cell.nameLabel.text = user.guardianname[indexPath.section]
        Cell.phoneLabel.text = user.guardianphonenumber[indexPath.section]
        return Cell
    }
    
    
}
