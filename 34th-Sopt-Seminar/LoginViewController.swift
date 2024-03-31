//
//  LoginViewController.swift
//  34th-Sopt-Seminar
//
//  Created by 오서영 on 2024/03/31.
//

import Foundation
import UIKit

final class LoginViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 69, y: 161, width: 236, height: 44))
        label.text = "동네라서 가능한 모든것\n당근에서 가까운 이웃과 함께해요."

        //        label.textColor = .black
        label.textColor = .orange // 과제 1 - 1
        
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = UIFont(name: "Pretendard-Bold", size: 18)
        return label
    }()
    
    private let idTextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 20, y: 276, width: 335, height: 52))
        textField.placeholder = "아이디를 입력해주세요"
        textField.font = UIFont(name: "Pretendard-SemiBold", size: 14)
        textField.backgroundColor = UIColor(red: 221/255, green: 222/255, blue: 227/255, alpha: 1)
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 20, y: 335, width: 335, height: 52))
        textField.placeholder = "비밀번호를 입력해주세요"
        textField.font = UIFont(name: "Pretendard-SemiBold", size: 14)
        textField.backgroundColor = UIColor(red: 221/255, green: 222/255, blue: 227/255, alpha: 1)
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
//        let button = UIButton(frame: CGRect(x: 21, y: 422, width: 332, height: 58))
        let button = UIButton(frame: CGRect(x: 21, y: 482, width: 332, height: 58))
        
        button.backgroundColor = UIColor(red: 255/255, green: 111/255, blue: 15/255, alpha: 1)
        button.setTitle("로그인하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 18)
        button.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    // 과제 1 - 2
    // UISwitch 인스턴스 생성
    private let autoLoginSwitch: UISwitch = {
        let autoLoginSwitch = UISwitch()
        autoLoginSwitch.frame = CGRect(x: 150, y: 400, width: 0, height: 0) // 위치 지정, 크기는 UISwitch의 기본 크기를 사용
        autoLoginSwitch.isOn = false // 기본 상태 설정 (자동 로그인 비활성화)
        autoLoginSwitch.onTintColor = .orange // 활성화 상태의 색상 변경
        autoLoginSwitch.addTarget(self, action: #selector(autoLoginSwitchChanged), for: .valueChanged) // 스위치 상태 변경시 호출될 메서드 추가
        return autoLoginSwitch
    }()
    

    
    private func presentToWelcomeVC() {
        let welcomeViewController = WelcomeViewController()
        welcomeViewController.modalPresentationStyle = .formSheet
//        welcomeViewController.id = idTextField.text
        welcomeViewController.setLabelText(id: idTextField.text)
        self.present(welcomeViewController, animated: true)
    }
    
    private func pushToWelcomeVC() {
        let welcomeViewController = WelcomeViewController()
//        welcomeViewController.id = idTextField.text
        welcomeViewController.setLabelText(id: idTextField.text)
//        self.navigationController?.pushViewController(welcomeViewController, animated: true)
        
        // 과제 1 - 1
            UIView.animate(withDuration: 0.3, animations: {
                self.view.alpha = 0
            }) { [weak self] finished in
                if finished {
                    self?.navigationController?.pushViewController(welcomeViewController, animated: false)
                    // 페이드 아웃 효과 후에는 뷰의 투명도를 원상태로 복구
                    self?.view.alpha = 1
                }
            }
    }
    
    @objc
    private func loginButtonDidTap() {
//        presentToWelcomeVC()
        pushToWelcomeVC()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        setLayout()
    }
    
    private func setLayout() {
        [titleLabel, idTextField, passwordTextField, loginButton].forEach {
            self.view.addSubview($0)
            
            self.view.addSubview(autoLoginSwitch)
            
        }
    }
    
    
    // 스위치 상태 변경시 호출될 메서드
        @objc func autoLoginSwitchChanged(_ sender: UISwitch) {
            if sender.isOn {
                print("자동 로그인 활성화")
            } else {
                print("자동 로그인 비활성화")
            }
        }
    
}

