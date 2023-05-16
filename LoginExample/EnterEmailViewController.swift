//
//  EnterEmailViewController.swift
//  LoginExample
//
//  Created by Eunchan Kim on 2023/05/11.
//

import UIKit
import FirebaseAuth


class EnterEmailViewController:UIViewController{
    @IBOutlet weak var emailTf: UITextField!
    @IBOutlet weak var passwordTf: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextBtn.layer.cornerRadius = 30
        nextBtn.isEnabled = false
        
        //텍스트필드 값 전달하기 위한 델리게이트
        emailTf.delegate = self
        passwordTf.delegate = self
        
        //커서가 바로 위치할 수 있도록
        emailTf.becomeFirstResponder()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //navigationBar 다시 보이게
        navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func nextBtnTapped(_ sender: UIButton) {
        //Firebase 이메일/비밀번호 인증
        let email = emailTf.text ?? ""
        let password = passwordTf.text ?? ""
        
        //신규사용자 생성
        Auth.auth().createUser(withEmail: email, password: password){[weak self] authResult, error in
            guard let self = self else {return}
            
            if let error = error {
                let code = (error as NSError).code
                switch code {
                case 17007: //이미 가입한 계정일 때
                    self.loginUser(withEmail: email, password: password)
                    //로그인하기
                default:
                    self.errorMessageLabel.text = error.localizedDescription
                }
            }else {
                self.showMainViewController()
            }
        }
        
    }

private func showMainViewController(){
    let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
    let mainViewController = sb.instantiateViewController(withIdentifier: "MainViewController")
    mainViewController.modalPresentationStyle = .fullScreen
    navigationController?.show(mainViewController, sender: nil)
    
}
private func loginUser(withEmail email: String, password: String){
    Auth.auth().signIn(withEmail: email, password: password){[weak self] _, error in
        guard let self = self else {return}
        if let error = error {
            self.errorMessageLabel.text = error.localizedDescription
        } else {
            self.showMainViewController()
        }
    }
}
}
extension EnterEmailViewController: UITextFieldDelegate{
    //리턴 눌렀을때 키보드가 내려가기
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let isEmailEmpty = emailTf.text == ""
        let isPasswordEmpty = passwordTf.text == ""
        //텍스트필드 둘다 비어있지 않을 때 다음버튼 활성화
        nextBtn.isEnabled = !isEmailEmpty && !isPasswordEmpty
    }
}
