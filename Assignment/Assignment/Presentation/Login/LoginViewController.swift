//
//  LoginViewController.swift
//  Assignment
//
//  Created by 오서영 on 6/21/24.
//

import UIKit
import SnapKit
import SwiftUI

final class LoginViewController: UIViewController {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "TVING ID 로그인"
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = UIFont(name: "Pretendard-Bold", size: 23)
        return label
    }()
    
    private let idTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "아이디"
        textField.font = UIFont(name: "Pretendard-SemiBold", size: 15)
        textField.backgroundColor = .gray4
        textField.textColor = .gray4
        textField.layer.cornerRadius = 3
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호"
        textField.font = UIFont(name: "Pretendard-SemiBold", size: 15)
        textField.backgroundColor = .gray4
        textField.textColor = .gray2
        textField.layer.cornerRadius = 3
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("로그인하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 14)
        button.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)
        button.isEnabled = false
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 46/255, green: 46/255, blue: 46/255, alpha: 1).cgColor
        return button
    }()
    
    private func pushToWelcomeVC() {
        let welcomeViewController = WelcomeViewController()
//        welcomeViewController.delegate = self
//        welcomeViewController.setLabelText(id: idTextField.text)
        self.navigationController?.pushViewController(welcomeViewController, animated: true)
    }
    
    @objc
    private func loginButtonDidTap() {
        pushToWelcomeVC()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
        setLayout()
    }
    
    private func setLayout() {
        [titleLabel, idTextField, passwordTextField, loginButton].forEach {
            self.view.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(90)
            make.leading.equalTo(109)
        }
        
        idTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(31)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(52)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(idTextField.snp.bottom).offset(7)
            make.left.right.height.equalTo(idTextField)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(21)
            make.left.right.height.equalTo(idTextField)
        }
    }
    
    
}


// 프리뷰를 위한 코드
struct LoginViewController_Previews: PreviewProvider {
    static var previews: some View {
        LoginViewControllerRepresentable()
            .edgesIgnoringSafeArea(.all)
    }
}

struct LoginViewControllerRepresentable: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> LoginViewController {
        LoginViewController()
    }
    
    func updateUIViewController(_ uiViewController: LoginViewController, context: Context) {
        
    }
}

// MARK: - Preview Layout Customization
extension LoginViewController_Previews {
    static var platform: PreviewPlatform? = .iOS
    static var devices: [String] = ["iPhone 15 Pro"]
}
