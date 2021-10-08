

import UIKit
import PhotosUI
import Firebase
import FirebaseStorage
import ProgressHUD

class AddSubAchievementViewController: UIViewController, UITextViewDelegate {
    
    //MARK: - Outlet
    
    @IBOutlet weak var CustomNavigationBar: CustomNavigationBar!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var nameTitleLabel: UILabel!
    @IBOutlet weak var nameTextView: UITextView!
    @IBOutlet weak var descriptionTitleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var pictureTitleLabel: UILabel!
    @IBOutlet weak var addpictureButton: UIButton!
    @IBOutlet weak var pictureImage: UIImageView!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var alertLabel: UILabel!
    @IBOutlet weak var scrollContainerView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var nameTextViewHeight: NSLayoutConstraint!
    @IBOutlet weak var contentTextViewHeight: NSLayoutConstraint!
    
    //MARK: - Variable
    var mynavigationbarTitle: String = "Thành Tựu (Khác)"
    var isSelectedFromCell: Bool! = false
    var name: String = "???"
    var descriptiontext: String = "???"
    var achievementiamgeurlstring: String!
    var id: String = UUID().uuidString
    var imagePNGdata: Data?
    
    let userAccId = Auth.auth().currentUser!.uid
    let db = Firestore.firestore()
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewConfig()
        LabelConfig()
        TextViewConfig()
        
        if isSelectedFromCell {
            acceptButton.isHidden = true
            addpictureButton.isHidden = true
            nameTextView.isEditable = false
            descriptionTextView.isEditable = false
            downloadPhotoForSubachievement()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        nameTextViewHeight.constant = nameTextView.contentSize.height
        contentTextViewHeight.constant = descriptionTextView.contentSize.height
        
    }
    
    private func viewConfig() {
        containerView.backgroundColor = UIColor().ContainerViewColor()
        
        scrollView.delaysContentTouches = false
        scrollContainerView.backgroundColor = .clear
        
        backgroundImage.image = UIImage(named: "im_BackgroundDecoBott")
        backgroundImage.contentMode = .scaleAspectFill
        
        CustomNavigationBar.backgroundColor = .clear
        CustomNavigationBar.titleLabel.text = mynavigationbarTitle
        CustomNavigationBar.backButton.addTarget(self, action: #selector(backButtonDidTapp(_ :)), for: .touchUpInside)
        
        addpictureButton.setTitle("+", for: .normal)
        addpictureButton.setTitleColor(UIColor().MainTextColor(alpha: 1), for: .normal)
        addpictureButton.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .medium)
        
        acceptButton.setImage(UIImage(named: "ic_AcceptButton")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), for: .normal)
        acceptButton.setTitle("", for:  .normal)
        
        pictureImage.image = UIImage(named: "Unknown")
        pictureImage.contentMode = .scaleAspectFit
        
    }
    
    
    private func TextViewConfig() {
        let textviewarray = [nameTextView, descriptionTextView]
        
        for val in textviewarray {
            val?.delegate = self
            val?.backgroundColor = .white
            val?.layer.borderWidth = 2
            val?.layer.borderColor = UIColor().BorderColor().cgColor
            val?.textColor = UIColor().SubTextColor(alpha: 1)
            val?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
            val?.addDoneButtonOnKeyboard()
        }
        nameTextView.text = name
        descriptionTextView.text = descriptiontext
    }
    
    private func LabelConfig() {
        let labelarray = [nameTitleLabel, descriptionTitleLabel, pictureTitleLabel, alertLabel]
        
        for val in labelarray {
            val?.textColor = UIColor().MainTextColor(alpha: 1)
            val?.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        }
        
        nameTitleLabel.text = " 1. Tên:"
        
        descriptionTitleLabel.text = " 2. Miêu Tả:"
        
        pictureTitleLabel.text = " 3. Ảnh:"
        
        alertLabel.text = id
        alertLabel.numberOfLines = 0
        alertLabel.textAlignment = .center
    }
    
    //MARK: - Helper
    func uploadDataToStorage(data: Data?) {
        let storageRef = Storage.storage().reference().child("\(userAccId)/\(id).png")
        
        guard let data = data else {
            print("no png data")
            ProgressHUD.dismiss()
            return
        }

        storageRef.putData(data, metadata: nil) {[weak self] Metadata, error in
            
            guard error == nil else {
                ProgressHUD.dismiss()
                return
            }
            
            storageRef.downloadURL { url, error in
                guard let url = url, error == nil else {
                    ProgressHUD.dismiss()
                    return
                }
                
                self?.uploadDataToFirestore(urlstring: url.absoluteString)
            }
            self?.alertLabel.text = "Gửi yêu cầu thành công với ID \(self!.id)"
            ProgressHUD.dismiss()
        }
    }
    
    
    func uploadDataToFirestore(urlstring: String) {
        let FirestoreRef = db.collection("users").document(userAccId).collection("subachievements").document(id)
        
        FirestoreRef.setData(["name": nameTextView.text!, "description": descriptionTextView.text!, "id": id, "imageurl": urlstring])
    }
    
    func downloadPhotoForSubachievement() {
        let photourl = URL(string: achievementiamgeurlstring)
        
        guard let photourl = photourl else {
            return
        }
        DispatchQueue.global().async {
            guard let data = try? Data.init(contentsOf: photourl) else {
                DispatchQueue.main.async {
                    self.pictureImage.image = UIImage(named: "Unknown")
                }
                return
            }
            DispatchQueue.main.async {
                self.pictureImage.image = UIImage.init(data: data)
            }
        }
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
        if textView == nameTextView {
            nameTextViewHeight.constant = nameTextView.contentSize.height
            nameTextView.layoutIfNeeded()
        }
        else {
            contentTextViewHeight.constant = descriptionTextView.contentSize.height
            descriptionTextView.layoutIfNeeded()
        }
    }
    
    //MARK: - DidTap
    @objc func backButtonDidTapp(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addButtonDidTap(_ sender: UIButton) {
        var configuration = PHPickerConfiguration()

        configuration.selectionLimit = 1
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func acceptButtonDidTap(_ sender: Any) {
        ProgressHUD.show()
        uploadDataToStorage(data: imagePNGdata)
    }
}

//MARK: - PHPickerViewControllerDelegate
extension AddSubAchievementViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true, completion: nil)
        
        if let itemProvider = results.first?.itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            let previousImage = pictureImage.image
            
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                DispatchQueue.main.async {
                    guard let image = image as? UIImage, self?.pictureImage.image == previousImage else { return }
                    
                    self?.imagePNGdata = image.pngData()
                    self?.pictureImage.image = image
                }
            }
        }
    }
    
    
}
