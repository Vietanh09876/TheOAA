
import UIKit
import Firebase
import ProgressHUD

class SettingViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var CustomNavigationBar: CustomNavigationBar!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewConfig()
        tableViewConfig()
    }
    
    private func viewConfig() {
        containerView.backgroundColor = UIColor().ContainerViewColor()
        backgroundImage.image = UIImage(named: "im_BackgroundDeco")
        backgroundImage.contentMode = .scaleAspectFill
        
        CustomNavigationBar.backgroundColor = .clear
        CustomNavigationBar.titleLabel.text = "Cài Đặt"
        CustomNavigationBar.backButton.addTarget(self, action: #selector(backButtonDidTap(_ :)), for: .touchUpInside)
        
    }
    
    private func tableViewConfig() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.separatorColor = UIColor().TableViewSeparatorColor()
        tableView.separatorInset.left = 15
        tableView.separatorInset.right = 15
        
        tableView.register(UINib(nibName: "SettingCell", bundle: nil), forCellReuseIdentifier: "SettingCell")
    
    }
    //MARK: - DidTap
    @objc func backButtonDidTap(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func signout () {
        if let _ = try? Auth.auth().signOut() {
            let root = self.view.window?.windowScene?.delegate as? SceneDelegate
            root?.setRootView()
        }
        else {
            print("Sign out Error")
        }
    }
}

//MARK: - Tableview Datasource, Delegate
extension SettingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath) as! SettingCell
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = UIColor().CellSelectedBackgroundColor()
        
        Cell.selectedBackgroundView = selectedBackgroundView
        Cell.mylabel.text = "Đăng Xuất"
        Cell.settingimageView.image = UIImage(named: "ic_LogOut")
        return Cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        signout()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
}
