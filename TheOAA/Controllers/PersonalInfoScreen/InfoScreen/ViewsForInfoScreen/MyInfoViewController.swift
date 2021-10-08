//
//  MyInfoViewController.swift
//  TheOAA
//
//  Created by Nguyễn Việt Anh on 18/09/2021.
//

import UIKit

class MyInfoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var personalinfo = ["???", "???", "???", "???", "???", "???", "???"]
    
    var titlearray = ["Họ Và Tên", "Ngày Sinh", "Giới Tính", "Năm Học", "SĐT", "Dân Tộc", "Địa Chỉ"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewConfig()
        tableViewConfig()
    }
    
    func viewConfig() {
        self.view.backgroundColor = .clear
        
    }
    
    func tableViewConfig() {
        tableView.dataSource = self
        tableView.delegate = self
        
        
        tableView.backgroundColor = .clear
        tableView.separatorColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UINib(nibName: "InfoCell", bundle: nil), forCellReuseIdentifier: "InfoCell")
    }
    
    

}

extension MyInfoViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return titlearray.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath) as! InfoCell
        
        Cell.titleLabel.text = titlearray[indexPath.section]
        Cell.contentLabel.text = personalinfo[indexPath.section]
        Cell.selectionStyle = .none
        
        return Cell
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .clear
        view.isHidden = true
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

