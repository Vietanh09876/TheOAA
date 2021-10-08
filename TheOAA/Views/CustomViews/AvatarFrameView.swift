//height: 58

import UIKit
import Firebase
import ProgressHUD

class AvatarFrameView: UIView {
    
    //MARK: - Outlet
    @IBOutlet weak var avatarframeImage: UIImageView!
    
    @IBOutlet weak var avatarpicImage: UIImageView!
    
    @IBOutlet weak var nameIdLabel: UILabel!
    
    @IBOutlet var nameIdTapGesture: UITapGestureRecognizer!
    
    //MARK: - Variable
    var name: String!
    var id: String!
    var avatarimageurl: String!
    
    let userAccId = Auth.auth().currentUser!.uid
    let db = Firestore.firestore()
    var userFirestoreDoc: DocumentReference!
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
        viewConfig()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
        viewConfig()
        
    }
    
    //MARK: - ViewConfig
    func commonInit() {
        name = "???"
        id = "???"
        avatarimageurl = "???"
        
        
        guard let view = LoadViewFromNib() else { return }
        
        view.backgroundColor = .clear
        view.frame = self.bounds
        self.addSubview(view)
        
    }
    
    func LoadViewFromNib() -> UIView? {
        let nib = UINib(nibName: "AvatarFrameView", bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first! as? UIView
    }
    
    
    func viewConfig() {
        
        
        avatarframeImage.image = UIImage(named: "im_AvatarFrame")
        avatarframeImage.contentMode = .scaleToFill
        
        avatarpicImage.image = UIImage(named: "Unknown_person")
        avatarpicImage.contentMode = .scaleToFill
        
        nameIdLabel.numberOfLines = 0
        nameIdLabel.font = UIFont.systemFont(ofSize: 15)
        nameIdLabel.attributedText = AvatarNameAttributedString()
        nameIdLabel.sizeToFit()
        nameIdLabel.isUserInteractionEnabled = true

    }
    
    //MARK: - Helpers
    func AvatarNameAttributedString() -> NSMutableAttributedString {
        let modName = NSAttributedString(string: "\(name!)\n", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .medium)])
        
        let modId = NSAttributedString(string: "#\(id!)", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.76, green: 0.76, blue: 0.76, alpha: 1.00), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)])
        
        let Attributednameid = NSMutableAttributedString()
        Attributednameid.append(modName)
        Attributednameid.append(modId)
        
        return Attributednameid
    }
    
    func fetchData() {
        
        userFirestoreDoc = db.collection("users").document(userAccId)
        
        userFirestoreDoc.getDocument {[weak self] document, error in
            guard let document = document else {
                print("Error fetching document: \(error!)")
                return
            }
            guard let data = document.data() else {
                print("Document data was empty.")
                return
            }
            let name = data["name"] as! String
            let id = data["id"] as! String
            let avatarimageurl = data["avatarimageurl"] as! String
            
            self?.name = name
            self?.id = id
            
            self?.nameIdLabel.attributedText = self?.AvatarNameAttributedString()
            
            self?.avatarpicImage.loadImageFromCacheWithUrlstring(urlstring: avatarimageurl)
            
        }
    }
    
}
