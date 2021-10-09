//MARK: Unfinished

import UIKit
import Firebase

class SignupViewController: UIViewController {
    
    
    //MARK: - Outlet
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var schoolnameLabel: UILabel!
    @IBOutlet weak var schoolnameTextField: UITextField!
    @IBOutlet weak var classnameLabel: UILabel!
    @IBOutlet weak var classnameTextField: UITextField!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var warningIcon: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    //MARK: - Variable
    var schoolPickerView = UIPickerView()
    var gradePickerView = UIPickerView()
    var TextFieldArray = [UITextField]()
    var LabelArray = [UILabel]()
    var nameofschoolArray: [String] = ["THPT 1", "THPT 2", "THPT 3"]
    var GradeAndClassArray: [[String]] = [["Khối 10", "Khối 11", "Khối 12"], ["10A1", "10D3", "10A2"], ["11A2", "11Anh"], ["12 Pháp", "12 Toán", "12A1"]]
    var pickedgrade: Int = 0
    var isDataValid: Bool!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewConfig()
        TextFieldConfig()
        PickerViewConfig()
    }
    
    private func viewConfig() {
        LabelArray = [mailLabel, nameLabel, schoolnameLabel, classnameLabel, idLabel, passwordLabel]
        
        self.view.backgroundColor = UIColor().ContainerViewColor()
        containerView.backgroundColor = UIColor.clear
        backgroundImage.image = UIImage(named: "im_BackgroundDeco")
        backgroundImage.contentMode = .scaleAspectFill
        
        scrollView.delaysContentTouches = false
        scrollView.showsVerticalScrollIndicator = false
        
        titleLabel.textColor = UIColor(red: 0.23, green: 0.35, blue: 0.28, alpha: 1.00)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 48)
        titleLabel.text = "OAA"
        
        
        for val in LabelArray {
            val.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            val.textAlignment = .left
            val.textColor = UIColor().MainTextColor(alpha: 0.7)
        }
        
        mailLabel.text = "Email"
        nameLabel.text = "Họ Và Tên"
        schoolnameLabel.text = "Trường"
        classnameLabel.text = "Khối - Lớp"
        idLabel.text = "Mã Học Sinh"
        passwordLabel.text = "Mật Khẩu"
        
        
        signupButton.setTitle("", for: .normal)
        signupButton.setBackgroundImage(UIImage(named: "im_SignupButton"), for: .normal)
        
        
        warningIcon.isHidden = true
        warningIcon.image = UIImage(named: "ic_Warning")
        warningIcon.contentMode = .scaleAspectFit
        
        
        warningLabel.isHidden = true
        warningLabel.textAlignment = .center
        warningLabel.numberOfLines = 0
        warningLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        warningLabel.textColor = UIColor().WarningTextColor()
        warningLabel.text = "Bạn chưa điền đầy đủ thông tin"
        warningLabel.sizeToFit()
        
        
        let backButtonImageConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .bold, scale: .large)
        backButton.setImage(UIImage(systemName: "arrow.left", withConfiguration: backButtonImageConfig), for: .normal)
        backButton.tintColor = UIColor().MainTextColor(alpha: 1)
        backButton.setTitle(nil, for: .normal)
        
    }
    
    private func TextFieldConfig() {
        TextFieldArray = [mailTextField, nameTextField, schoolnameTextField, classnameTextField, idTextField, passwordTextField]
        
        
        for val in TextFieldArray {
            val.borderStyle = .none
            val.background = UIImage(named: "im_TextField")
            val.textColor = UIColor().SubTextColor(alpha: 1)
            val.font = UIFont.boldSystemFont(ofSize: 17)
            val.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: idTextField.bounds.height))
            val.leftViewMode = .always
            val.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: idTextField.bounds.height))
            val.rightViewMode = .always
            val.delegate = self
        }
        
        mailTextField.placeholder = "vd: mail@oaa.com"
        nameTextField.placeholder = "vd: Nguyễn Văn A"
        schoolnameTextField.placeholder = "vd: THPT"
        classnameTextField.placeholder = "vd: 11A, 10A2, 10D1"
        idTextField.placeholder = "vd: 666"
        passwordTextField.placeholder = "???"
        
        mailTextField.keyboardType = .emailAddress
        
        schoolnameTextField.addDoneButtonOnKeyboard()
        schoolnameTextField.inputView = schoolPickerView
        
        classnameTextField.addDoneButtonOnKeyboard()
        classnameTextField.inputView = gradePickerView
        
        passwordTextField.isSecureTextEntry = true
    }

    
    func PickerViewConfig() {
        schoolPickerView.dataSource = self
        schoolPickerView.delegate = self
        
        gradePickerView.dataSource = self
        gradePickerView.delegate = self
    }
    
    //MARK: - Helper
    func CheckDataValid() {
        isDataValid = true
        for (ind, va) in TextFieldArray.enumerated() {
            if TextFieldArray[0].text!.isEmpty || TextFieldArray[0].text!.contains("@") == false || TextFieldArray[0].text!.contains(".") == false {
                TextFieldArray[0].textColor = UIColor().WarningTextColor()
                isDataValid = false
            }
            if va.text!.isEmpty {
                LabelArray[ind].textColor = UIColor().WarningTextColor()
                isDataValid = false
            }
            else {
                LabelArray[ind].textColor = UIColor().MainTextColor(alpha: 1)
            }
        }
    }
    
    
    
    //MARK: - DidTap
    @IBAction func backButtonDidTap(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func signupButtonDidTap(_ sender: Any) {
        CheckDataValid()
        if isDataValid {
            print("ok")
        }
        else {
            warningIcon.isHidden = false
            warningLabel.isHidden = false
        }
    }
    
}

//MARK: - PickerView DataSource, Delegate

extension SignupViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == schoolPickerView {
            return 1
        }
        else {
            return 2
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case schoolPickerView:
            return nameofschoolArray.count
        case gradePickerView:
            if component == 0 {
                return GradeAndClassArray[0].count
            }
            else {
                return GradeAndClassArray[pickedgrade+1].count
            }
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case schoolPickerView:
            return nameofschoolArray[row]
        case gradePickerView:
            if component == 0 {
                return GradeAndClassArray[0][row]
            }
            else {
                return GradeAndClassArray[pickedgrade+1][row]
            }
        default:
            return "??"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case schoolPickerView:
            schoolnameTextField.text = nameofschoolArray[row]
        case gradePickerView:
            if component == 0 {
                pickedgrade = row
                pickerView.reloadComponent(1)
            }
            else {
                classnameTextField.text = "\(GradeAndClassArray[0][pickedgrade]) - \(GradeAndClassArray[pickedgrade+1][row])"
            }
        default:
            return
        }
    }
}


//MARK: - TextFieldDelegate
extension SignupViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
