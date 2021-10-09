//
//  LoginViewController.swift
//  TheOAA
//
//  Created by Nguyễn Việt Anh on 05/09/2021.
//

import UIKit
import Firebase
import ProgressHUD

class LoginViewController: UIViewController {

    //MARK: - Outlet
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var forgotButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var warningIcon: UIImageView!
    @IBOutlet weak var signupButton: UIButton!
    
    //MARK: - Variable
    let SignupButtonAttributedString = NSMutableAttributedString(string: "Chưa Có Tài Khoản? Đăng Ký")
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        viewConfig()
        TextFieldConfig()
        
    }
    
    
    private func viewConfig() {
        SignupButtonAttributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 19, length: 7))
        
        containerView.backgroundColor = UIColor().ContainerViewColor()
        backgroundImage.image = UIImage(named: "im_BackgroundDeco")
        backgroundImage.contentMode = .scaleAspectFill
        
        
        titleLabel.textColor = UIColor(red: 0.23, green: 0.35, blue: 0.28, alpha: 1.00)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 48)
        titleLabel.text = "OAA"
        
        
        idLabel.text = "Email"
        idLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        idLabel.textAlignment = .left
        idLabel.textColor = UIColor().MainTextColor(alpha: 0.7)
        
        
        passwordLabel.text = "Mật Khẩu"
        passwordLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        passwordLabel.textAlignment = .left
        passwordLabel.textColor = UIColor().MainTextColor(alpha: 0.7)
        
        
        forgotButton.setAttributedTitle(NSAttributedString(string: "Quên Mật Khẩu?", attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]), for: .normal)
        forgotButton.setTitleColor(UIColor().MainTextColor(alpha: 0.7), for: .normal)
        forgotButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        forgotButton.titleLabel?.textAlignment = .right
        
        signupButton.isHidden = false
        signupButton.setAttributedTitle(SignupButtonAttributedString, for: .normal)
        signupButton.setTitleColor(UIColor().MainTextColor(alpha: 0.7), for: .normal)
        signupButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        
        
        loginButton.setTitle("", for: .normal)
        loginButton.setBackgroundImage(UIImage(named: "im_LoginButton"), for: .normal)
        
        
        warningIcon.isHidden = true
        warningIcon.image = UIImage(named: "ic_Warning")
        warningIcon.contentMode = .scaleAspectFit
        
        
        warningLabel.isHidden = true
        warningLabel.textAlignment = .center
        warningLabel.numberOfLines = 0
        warningLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        warningLabel.sizeToFit()
        
    }
    
    private func TextFieldConfig() {
        let textfieldarray = [idTextField, passwordTextField]
        
        for val in textfieldarray {
            val?.borderStyle = .none
            val?.background = UIImage(named: "im_TextField")
            val?.textColor = UIColor().SubTextColor(alpha: 1)
            val?.font = UIFont.boldSystemFont(ofSize: 17)
            val?.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: idTextField.bounds.height))
            val?.leftViewMode = .always
            val?.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: idTextField.bounds.height))
            val?.rightViewMode = .always
            val?.delegate = self
        }
        
        idTextField.placeholder = "Email"
        passwordTextField.placeholder = "Mật Khẩu"
        
        idTextField.keyboardType = .emailAddress
        passwordTextField.isSecureTextEntry = true
    }
    
    
    //MARK: - Helper
    func signIn() {
        Auth.auth().signIn(withEmail: self.idTextField.text!, password: self.passwordTextField.text!) {[weak self] authresult, error in
            ProgressHUD.show()
            if error == nil {
                let tabbar = UITabBarController().MyCustomMainTabBar()
                self?.navigationController?.pushViewController(tabbar, animated: true)
            }
            else {
                self?.warningLabel.textColor = UIColor().WarningTextColor()
                self?.warningLabel.text = "Hãy kiểm tra lại email hoặc mật khẩu của bạn"
                self?.warningIcon.isHidden = false
                self?.warningLabel.isHidden = false
            }
            ProgressHUD.dismiss()
        }
    }
    
    func sendEmailResetPassword() {
        Auth.auth().sendPasswordReset(withEmail: idTextField.text!) {[weak self] error in
            ProgressHUD.show()
            self?.warningLabel.textColor = UIColor().WarningTextColor()
            self?.warningIcon.isHidden = true
            self?.warningLabel.isHidden = false
            if error != nil {
                self?.warningLabel.text = "Không thể gửi email yêu cầu khôi phục mật khẩu, hãy thử lại sau."
            }
            else {
                self?.idLabel.textColor = UIColor(red: 0.64, green: 0.20, blue: 0.20, alpha: 1.00)
                self?.passwordLabel.textColor = UIColor(red: 0.64, green: 0.20, blue: 0.20, alpha: 1.00)
                self?.warningLabel.textColor = UIColor().MainTextColor(alpha: 1)
                self?.warningLabel.text = "Đã gửi email yêu cầu khôi phục mật khẩu."
            }
            ProgressHUD.dismiss()
        }
    }
    
    func isDataValid() -> Bool {
        if idTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            return false
        }
        else {
            return true
        }
    }
    
    
    //MARK: - UIButton Action
    @IBAction func forgotButtonDidTap(_ sender: UIButton) {
        if idTextField.text!.isEmpty || idTextField.text!.contains("@") == false || idTextField.text!.contains(".") == false  {
            idLabel.textColor = UIColor(red: 0.64, green: 0.20, blue: 0.20, alpha: 1.00)
            
        }
        else {
            idLabel.textColor = UIColor().MainTextColor(alpha: 0.7)
            sendEmailResetPassword()
        }
    }
    
    
    @IBAction func loginButtonDidTap(_ sender: UIButton) {
        if isDataValid() {
            signIn()
        }
        else {
            warningLabel.textColor = UIColor().WarningTextColor()
            warningLabel.text = "Bạn chưa điền đầy đủ thông tin"
            warningIcon.isHidden = false
            warningLabel.isHidden = false
            
        }
    }
    
    @IBAction func signupButtonDidTap(_ sender: Any) {
        let signupvc  = SignupViewController()
        navigationController?.pushViewController(signupvc, animated: true)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
