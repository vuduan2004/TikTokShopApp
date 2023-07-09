//
//  InFoUserViewController.swift
//  TikTokShop
//
//  Created by Khắc Hùng on 08/07/2023.
//

import UIKit

class InFoUserViewController: UIViewController {
    
    @IBOutlet weak var background1: UIView!
    @IBOutlet weak var btnLogOut: UIButton!
    @IBOutlet weak var btnUpdateInfo: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        background1.layer.cornerRadius = 20
        btnLogOut.layer.cornerRadius = 2
        btnUpdateInfo.layer.cornerRadius = 10
        
    }
    
    @IBAction func btnItemHome(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        
        navigationController?.setViewControllers([homeVC], animated: false)
        
        homeVC.navigationItem.hidesBackButton = true
        
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnLogOutAct(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let registerVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        
        navigationController?.setViewControllers([registerVC], animated: false)
        
        registerVC.navigationItem.hidesBackButton = true
        
        self.dismiss(animated: true, completion: nil)
    }
}
