//
//  LoginViewController.swift
//  Assignment
//
//  Created by 오서영 on 6/21/24.
//

import UIKit
import SnapKit
import SwiftUI

final class LoginViewController: UIViewController, DataBindProtocol {
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
        textField.backgroundColor = UIColor(named: "gray4")
        textField.textColor = UIColor(named: "gray2")
        textField.layer.cornerRadius = 3
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.clear.cgColor
        textField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호"
        textField.font = UIFont(name: "Pretendard-SemiBold", size: 15)
        textField.backgroundColor = .gray4
        textField.textColor = .gray2
        textField.layer.cornerRadius = 3
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.clear.cgColor
        textField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("로그인하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 14)
        button.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)
        button.isEnabled = false
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(named: "gray4")?.cgColor
        return button
    }()
    
    private lazy var findID: UILabel = {
        let label = UILabel()
        label.text = "아이디 찾기"
        label.font = UIFont(name: "Pretendard-SemiBold", size: 14)
        label.textColor = UIColor(named: "gray2")
        return label
    }()
    
    private let findPW : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-SemiBold", size: 14)
        label.text = "비밀번호 찾기"
        label.textColor = UIColor(named: "gray2")
        return label
    }()
    
    private let noAccount: UILabel = {
        let label = UILabel()
        label.text = "아직 계정이 없으신가요?"
        label.font = UIFont(name: "Pretendard-SemiBold", size: 14)
        label.textColor = UIColor(named: "gray3")
        return label
    }()
    
    private let nicknameButton: UIButton = {
        let button = UIButton()
        button.setTitle("닉네임 만들러가기", for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-Regular", size: 14)
        button.setTitleColor(UIColor(named: "gray2"), for: .normal)
        button.setUnderline()
        return button
    }()
    
    private let clearPasswordButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "x-circle")?.withTintColor(UIColor(named: "gray2") ?? .systemGray), for: .normal)
        button.addTarget(self, action: #selector(clearPasswordButtonTapped), for: .touchUpInside)
        button.isHidden = true
        button.isEnabled = false
        return button
    }()
    
    private let showPasswordButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "eye-slash")?.withTintColor(UIColor(named: "gray2") ?? .systemGray), for: .selected)
        button.setImage(UIImage(named: "eye")?.withTintColor(UIColor(named: "gray2") ?? .systemGray), for: .normal)
        button.addTarget(self, action: #selector(showPasswordButtonTapped), for: .touchUpInside)
        button.isHidden = true
        button.isEnabled = false
        return button
    }()
        
    private func pushToWelcomeVC() {
        let welcomeViewController = WelcomeViewController()
        welcomeViewController.delegate = self
        welcomeViewController.setLabelText(id: idTextField.text)
        self.navigationController?.pushViewController(welcomeViewController, animated: true)
    }
    
    func dataBind(id: String) {
        print("Received ID: \(id)")
    }
    
    private func updateLogin() {
        let isIdTextFieldNotEmpty = !(idTextField.text?.isEmpty ?? true)
        let isPasswordTextFieldNotEmpty = !(passwordTextField.text?.isEmpty ?? true)
        let isEnabled = isIdTextFieldNotEmpty && isPasswordTextFieldNotEmpty

        loginButton.isEnabled = isEnabled
        loginButton.backgroundColor = isEnabled ? UIColor.red : UIColor.black
    }
    
    @objc func clearPasswordButtonTapped(){
        passwordTextField.text = ""
    }
    
    @objc func showPasswordButtonTapped(){
        passwordTextField.isSecureTextEntry.toggle()
        showPasswordButton.isSelected.toggle()
    }

    @objc
    private func loginButtonDidTap() {
        pushToWelcomeVC()
    }
    
    @objc
    private func textFieldEditingChanged(_ textField: UITextField) {
        updateLogin()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
        setDelegate()
        setLayout()
        updateLogin()
    }
    
    private func setDelegate() {
        idTextField.delegate = self
        passwordTextField.delegate = self

    }
    
    private func setLayout() {
        [titleLabel, idTextField, passwordTextField, loginButton, findID, findPW, noAccount, nicknameButton, showPasswordButton, clearPasswordButton].forEach {
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
        
        findID.snp.makeConstraints {
            make in
            make.height.equalTo(22)
            make.leading.equalTo(loginButton.snp.leading).offset(65)
            make.top.equalTo(loginButton.snp.bottom).offset(31)
        }
        
        findPW.snp.makeConstraints{
            make in
            make.height.top.equalTo(findID)
            make.trailing.equalTo(loginButton.snp.trailing).offset(-66)
            
        }
        
        noAccount.snp.makeConstraints{
            make in
            make.height.equalTo(22)
            make.top.equalTo(findID.snp.bottom).offset(28)
            make.leading.equalTo(loginButton.snp.leading).offset(31)
        }
        
        nicknameButton.snp.makeConstraints{
            make in
            make.height.equalTo(22)
            make.top.equalTo(noAccount)
            make.leading.equalTo(noAccount.snp.trailing).offset(33)
        }
        
        showPasswordButton.snp.makeConstraints { make in
            make.width.equalTo(20)
            make.height.equalTo(20)
            make.centerY.equalTo(passwordTextField.snp.centerY)
            make.trailing.equalTo(passwordTextField.snp.trailing).inset(20)
        }

        clearPasswordButton.snp.makeConstraints { make in
            make.width.equalTo(20)
            make.height.equalTo(20)
            make.centerY.equalTo(passwordTextField.snp.centerY)
            make.trailing.equalTo(showPasswordButton.snp.leading).offset(-16)
        }
        
    }
    
    func updateBorderColor(for textField: UITextField, isActive: Bool) {
        textField.layer.borderColor = isActive ? UIColor(named: "gray2")?.cgColor : UIColor.clear.cgColor
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        updateBorderColor(for: textField, isActive: true)
        
        if textField == passwordTextField{
            showPasswordButton.isHidden = false
            showPasswordButton.isEnabled = true
            clearPasswordButton.isHidden = false
            clearPasswordButton.isEnabled = true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateBorderColor(for: textField, isActive: false)
        
        if textField == passwordTextField{
            showPasswordButton.isHidden = false
            showPasswordButton.isEnabled = true
            clearPasswordButton.isHidden = false
            clearPasswordButton.isEnabled = true
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        updateLogin()
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
