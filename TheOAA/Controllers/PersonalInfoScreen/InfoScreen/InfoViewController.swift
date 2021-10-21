//
//  InfoViewController.swift
//  TheOAA
//
//  Created by Nguyễn Việt Anh on 17/09/2021.
//

import UIKit
import PhotosUI
import Firebase
import FirebaseStorage
import ProgressHUD

class InfoViewController: UIViewController {
    
    //MARK: - Outlet
    
    @IBOutlet weak var pictureframeImage: UIImageView!
    @IBOutlet weak var userpictureImage: UIImageView!
    @IBOutlet weak var CustomSegmentControl: CustomSegmentControl!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var changeuserimageButton: UIButton!
    
    
    //MARK: - Variable
    var avatarimageurl: String!
    let myinfoview = MyInfoViewController()
    let communicationview = CommunicationViewController()
    let achievementview = AchievementViewController()
    var viewIsOn: Int!
    var isnotUser: Bool = true
    
    let userAccId = Auth.auth().currentUser!.uid
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewConfig()
        
        CustomSegmentControl.pressedbuttonindex = {[weak self] x in
            self?.removeSubview()
            
            self?.addSubview(viewnumber: x)
            
            self?.viewIsOn = x
        }
        
        CustomSegmentControl.buttonDidTap(CustomSegmentControl.firstButton)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        CustomSegmentControl.firstButton.centerVerticallyTextUnderImage(padding: 0)
        CustomSegmentControl.seccondButton.centerVerticallyTextUnderImage(padding: 0)
        CustomSegmentControl.thirdButton.centerVerticallyTextUnderImage(padding: 0)
    }
    

    private func viewConfig() {
        self.view.backgroundColor = .clear
        self.containerView.backgroundColor = .clear
        
        let buttonsarray: [UIButton?] = [self.CustomSegmentControl.firstButton, self.CustomSegmentControl.seccondButton, self.CustomSegmentControl.thirdButton]
        
        CustomSegmentControl.backgroundColor = .clear
        
        pictureframeImage.image = UIImage(named: "im_PictureFrame")
        pictureframeImage.contentMode = .scaleToFill
        
        userpictureImage.loadImageFromCacheWithUrlstring(urlstring: avatarimageurl)
        userpictureImage.contentMode = .scaleAspectFill
        
        CustomSegmentControl.backgroundColor = .clear
        
        CustomSegmentControl.firstButton.setTitle("Thông Tin", for: .normal)
        CustomSegmentControl.firstButton.setImage(UIImage(named: "ic_Infocard"), for: .normal)
        
        
        CustomSegmentControl.seccondButton.setTitle("Liên Lạc", for: .normal)
        CustomSegmentControl.seccondButton.setImage(UIImage(named: "ic_Phone"), for: .normal)
        
        
        CustomSegmentControl.thirdButton.setTitle("Thành Tựu", for: .normal)
        CustomSegmentControl.thirdButton.setImage(UIImage(named: "ic_Medal"), for: .normal)
        
        setButtonColor(buttonsarray: buttonsarray)
        
        let changeimageButtonImageConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .bold, scale: .medium)
        changeuserimageButton.setImage(UIImage(systemName: "pencil", withConfiguration: changeimageButtonImageConfig), for: .normal)
        changeuserimageButton.tintColor = UIColor().MainTextColor(alpha: 1)
        changeuserimageButton.setTitle(nil, for: .normal)
        changeuserimageButton.isHidden = isnotUser
    }
    
    //MARK: - Helper
    func uploadNewAvatarPictureToStorage(datapng: Data?) {
        let storageRef = Storage.storage().reference().child("\(userAccId)/avatarimage.png")
        
        guard let data = datapng else {
            ProgressHUD.dismiss()
            return
        }
        storageRef.putData(data, metadata: nil) { Metadata, error in
            guard error == nil else {
                ProgressHUD.dismiss()
                return
            }
            
            storageRef.downloadURL { url, error in
                guard let url = url, error == nil else {
                    ProgressHUD.dismiss()
                    return
                }
                self.avatarimageurl = url.absoluteString
                self.updateFirestoreData()
            }
            ProgressHUD.dismiss()
        }
    }
    
    func updateFirestoreData() {
        let userFirestoreDoc = Firestore.firestore().collection("users").document(userAccId)
        
        userFirestoreDoc.updateData(["avatarimageurl": avatarimageurl!])
    }
    
    func setButtonColor(buttonsarray: [UIButton?]) {
        
        for button in buttonsarray {
            button?.titleLabel?.font = UIFont.systemFont(ofSize: 11, weight: .bold)
            button?.tintColor = UIColor(red: 0.12, green: 0.34, blue: 0.19, alpha: 1.00)
            button?.setTitleColor(UIColor(red: 0.12, green: 0.34, blue: 0.19, alpha: 1.00), for: .normal)
        }
    }
    
    func addSubview(viewnumber x: Int){
        var buttonsarray = [CustomSegmentControl.firstButton, CustomSegmentControl.seccondButton, CustomSegmentControl.thirdButton]
        buttonsarray.remove(at: x-1)
        
        setButtonColor(buttonsarray: buttonsarray)
        switch x {
        case 1:
            self.addChild(myinfoview)
            containerView.addSubview(myinfoview.view)
            myinfoview.view.fitSuperviewConstraint()
            CustomSegmentControl.firstButton.tintColor = .white
            CustomSegmentControl.firstButton.setTitleColor(.white, for: .normal)
        case 2:
            self.addChild(communicationview)
            containerView.addSubview(self.communicationview.view)
            communicationview.view.fitSuperviewConstraint()
            CustomSegmentControl.seccondButton.tintColor = .white
            CustomSegmentControl.seccondButton.setTitleColor(.white, for: .normal)
            
        case 3:
            self.addChild(achievementview)
            containerView.addSubview(achievementview.view)
            achievementview.view.fitSuperviewConstraint()
            CustomSegmentControl.thirdButton.tintColor = .white
            CustomSegmentControl.thirdButton.setTitleColor(.white, for: .normal)
            
        default:
            return
        }
    }
    
    func removeSubview() {
        switch viewIsOn {
        case 1:
            myinfoview.view.removeFromSuperview()
            myinfoview.removeFromParent()
        case 2:
            communicationview.view.removeFromSuperview()
            communicationview.removeFromParent()
        case 3:
            achievementview.view.removeFromSuperview()
            achievementview.removeFromParent()
        default:
            return
        }
    }
    
    //MARK: - DidTap
    @IBAction func changeimageButtonDidTap(_ sender: Any) {
        var configuration = PHPickerConfiguration()

        configuration.selectionLimit = 1
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
}


//MARK: - PHPickerDelegate
extension InfoViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true, completion: nil)
        
        if let itemProvider = results.first?.itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            let previousImage = userpictureImage.image
            
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                DispatchQueue.main.async {
                    guard let image = image as? UIImage, self?.userpictureImage.image == previousImage else { return }
                    
                    ProgressHUD.show()
                    self?.userpictureImage.image = image
                    self?.uploadNewAvatarPictureToStorage(datapng: image.pngData())
                }
            }
        }
    }
}
    
