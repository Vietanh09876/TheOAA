//
//  NewsBoardViewController.swift
//  TheOAA
//
//  Created by Nguyễn Việt Anh on 06/09/2021.
//

import UIKit
import Firebase
import ProgressHUD

class NewsBoardViewController: UIViewController {
    
    //MARK: -Outlet
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var AvatarFrameView: AvatarFrameView!
    @IBOutlet weak var notifiButton: NotificationButton!
    @IBOutlet weak var settingButton: SettingButton!
    @IBOutlet weak var newsboardCollectionView: UICollectionView!
    
    //MARK: - Outlet ScrollView
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var scrollContainerView: UIView!
    
    
    
    //MARK: - Variable
    var newsImageArray = [UIImage]()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        viewConfig()
        CollectionViewConfig()
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

        scrollContainerView.backgroundColor = UIColor.clear
        ScrollView.showsVerticalScrollIndicator = false
        
        AvatarFrameView.nameIdTapGesture.addTarget(self, action: #selector(NameIdLabelDidTap(_:)))
        
        settingButton.addTarget(self, action: #selector(settingButtonDidTap(_ :)), for: .touchUpInside)
    }
    
    func CollectionViewConfig() {
        newsboardCollectionView.dataSource = self
        newsboardCollectionView.delegate = self
        newsboardCollectionView.backgroundColor = UIColor.clear
        newsboardCollectionView.showsHorizontalScrollIndicator = false
        if let layout = newsboardCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        newsboardCollectionView.register(UINib(nibName: "NewsBoardCell", bundle: nil), forCellWithReuseIdentifier: "NewsBoardCell")
        
    }
    
    
    //MARK: - Helper
    func fetchData() {
        newsImageArray.append(UIImage(named: "Unknown")!)
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

    //MARK: - CollectionViewDataSource, FlowLayout
extension NewsBoardViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == newsboardCollectionView {
            return newsImageArray.count
        }
        else {
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == newsboardCollectionView {
            let Cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsBoardCell", for: indexPath) as! NewsBoardCell
            
            Cell.ImageView.image = newsImageArray[indexPath.item]
            
            return Cell
        }
        else {
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let ShowBiggerVC = ShowBiggerPictureViewController()
        ShowBiggerVC.image = newsImageArray[indexPath.item]
        ShowBiggerVC.isModalInPresentation = true
        present(ShowBiggerVC, animated: true, completion: nil)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 125)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    
    
}
