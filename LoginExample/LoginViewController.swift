//
//  LoginViewController.swift
//  LoginExample
//
//  Created by Eunchan Kim on 2023/05/11.
//

import Foundation
import UIKit
import GoogleSignIn

class LoginViewController: UIViewController{
    
    @IBOutlet weak var emailLoginBtn: UIButton!
    @IBOutlet weak var googleLoginBtn: GIDSignInButton!
    @IBOutlet weak var appleLoginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        [emailLoginBtn, googleLoginBtn, appleLoginBtn].forEach {
            $0?.layer.borderWidth = 1
            $0?.layer.borderColor = UIColor.white.cgColor
            $0?.layer.cornerRadius = 30
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //navigationBar 숨기기
        navigationController?.navigationBar.isHidden = true
        
        //Google Sign in
        GIDSignIn.sharedInstance().presentingViewController = self
    }
    
    @IBAction func googleLoginButtonTapped(_ sender: UIButton) {
        //firebase 인증
        GIDSignIn.sharedInstance().signIn()
    }
    
  
    @IBAction func appleLoginButtonTapped(_ sender: UIButton) {
        //firebase 인증
    }
}
