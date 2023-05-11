//
//  EnterEmailViewController.swift
//  LoginExample
//
//  Created by Eunchan Kim on 2023/05/11.
//

import UIKit

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
