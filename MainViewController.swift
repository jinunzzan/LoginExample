//
//  MainViewController.swift
//  LoginExample
//
//  Created by Eunchan Kim on 2023/05/11.
//

import UIKit

class MainViewController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //메인화면에서 뒤로가기가 되면 이상하겠죠? 뒤로가기 안되게 pop제스처 막기
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //네비게이션바를 다시 숨겨주기
        navigationController?.navigationBar.isHidden = true
    }
}
