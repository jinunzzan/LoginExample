//
//  MainViewController.swift
//  LoginExample
//
//  Created by Eunchan Kim on 2023/05/11.
//

import UIKit
import FirebaseAuth

class MainViewController: UIViewController{
    
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var resetPasswordBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //메인화면에서 뒤로가기가 되면 이상하겠죠? 뒤로가기 안되게 pop제스처 막기
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //네비게이션바를 다시 숨겨주기
        navigationController?.navigationBar.isHidden = true
        
        let email = Auth.auth().currentUser?.email ?? "고객"
        welcomeLabel.text = """
환영합니다.
\(email)님
"""
        
        //이메일 로그인일 경우만 버튼이 보이도록!
        let isEmailSignIn = Auth.auth().currentUser?.providerData[0].providerID == "password"
        resetPasswordBtn.isHidden = !isEmailSignIn
    }
    
    
    @IBAction func logoutBtnTapped(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        
        do {
            try firebaseAuth.signOut()
            //첫화면으로 pop
            self.navigationController?.popToRootViewController(animated: true)
        }catch let signOutError as NSError {
            print("ERROR: signOut \(signOutError.localizedDescription)")
        }
    }

    //비밀번호 변경
    @IBAction func resetPasswordBtnTapped(_ sender: UIButton) {
        let email =  Auth.auth().currentUser?.email ?? ""
        Auth.auth().sendPasswordReset(withEmail: email, completion: nil)
    }
}
