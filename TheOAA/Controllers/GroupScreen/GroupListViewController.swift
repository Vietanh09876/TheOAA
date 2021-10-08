//
//  GroupListViewController.swift
//  TheOAA
//
//  Created by Nguyễn Việt Anh on 08/09/2021.
//

import UIKit
import Firebase

class GroupListViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var AvatarFrameView: AvatarFrameView!
    @IBOutlet weak var notifiButton: NotificationButton!
    @IBOutlet weak var settingButton: SettingButton!
    
    
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AvatarFrameView.fetchData()
    }
    
    private func viewConfig() {
        
        containerView.backgroundColor = UIColor().ContainerViewColor()
        backgroundImage.image = UIImage(named: "im_BackgroundDeco")
        backgroundImage.contentMode = .scaleAspectFill
        
        AvatarFrameView.backgroundColor = .clear
        AvatarFrameView.nameIdTapGesture.addTarget(self, action: #selector(NameIdLabelDidTap(_:)))
        
        settingButton.addTarget(self, action: #selector(settingButtonDidTap(_ :)), for: .touchUpInside)
        
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
    
}

