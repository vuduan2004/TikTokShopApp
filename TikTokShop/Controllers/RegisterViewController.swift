//
//  RegisterViewController.swift
//  TikTokShop
//
//  Created by Khắc Hùng on 03/07/2023.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var txtPasswordVerification: UITextField!
    @IBOutlet weak var txtPassWord: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var txtUserName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnRegister.layer.cornerRadius = 18
        
    }
    
    
    func registerUser(user: User) {
        var users = getUsers()
        users.append(user)
        saveUsers(users: users)
    }
    
    
    
    func getUsers() -> [User] {
        if let data = UserDefaults.standard.data(forKey: "users") {
            if let users = try? JSONDecoder().decode([User].self, from: data) {
                return users
            }
        }
        return []
    }
    
    
    
    func saveUsers(users: [User]) {
        if let encoded = try? JSONEncoder().encode(users) {
            UserDefaults.standard.set(encoded, forKey: "users")
        }
    }
    
    func validateFields() -> String? {
        if txtUserName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            txtPassWord.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            txtPasswordVerification.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            txtFullName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Vui lòng điền đầy đủ thông tin."
        }
        
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        if !emailPredicate.evaluate(with: txtEmail.text) {
            return "Email không hợp lệ."
        }
        
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        if !passwordPredicate.evaluate(with: txtPassWord.text) {
            return "Mật khẩu phải có ít nhất 8 ký tự, bao gồm chữ hoa, chữ thường và số."
        }
        
        if txtPassWord.text != txtPasswordVerification.text {
            return "Mật khẩu và xác nhận mật khẩu không khớp."
        }
        
        return nil
    }
    
    func showError(_ message: String) {
        let alert = UIAlertController(title: "Lỗi", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    func showSuccess() {
        let alert = UIAlertController(title: "Thành công", message: "Đăng ký tài khoản thành công!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func btnRegister(_ sender: UIButton) {
        let error = validateFields()
        
        if error != nil {
            showError(error!)
        } else {
            let username = txtUserName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = txtPassWord.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = txtEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let fullName = txtFullName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let user = User(username: username, password: password, email: email, fullName: fullName)
            registerUser(user: user)
            showSuccess()
            
        }
    }
}
