//
//  LoginViewController.swift
//  TikTokShop
//
//  Created by Khắc Hùng on 03/07/2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var txtPassWord: UITextField!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnLogin.layer.cornerRadius = 18
        btnRegister.layer.cornerRadius = 18
        
        
    }
    
    @IBAction func btnLogin(_ sender: UIButton) {
        let username = txtUserName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = txtPassWord.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let users = getUsers()
        
        for user in users {
            if user.username == username && user.password == password {
                UserDefaults.standard.set(username, forKey: "username")
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                
                navigationController?.setViewControllers([homeVC], animated: true)
                homeVC.navigationItem.hidesBackButton = true
                UserDefaults.standard.set(username, forKey: "username")
                self.dismiss(animated: true, completion: nil)
                
                return
            }
        }
        
        showError("Tên tài khoản hoặc mật khẩu không đúng.")
    }
    
    func getUsers() -> [User] {
        if let data = UserDefaults.standard.data(forKey: "users") {
            if let users = try? JSONDecoder().decode([User].self, from: data) {
                return users
            }
        }
        return []
    }
    
    func showError(_ message: String) {
        let alert = UIAlertController(title: "Lỗi", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
