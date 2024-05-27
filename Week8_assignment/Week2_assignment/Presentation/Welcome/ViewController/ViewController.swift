//
//  ViewController.swift
//  Week2_assignment
//
//  Created by 오서영 on 2024/04/10.
//

import UIKit
import SnapKit

// UIColor를 확장하여 HEX 색상 코드 사용 가능하게 함
extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        let hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

class ViewController: UIViewController, UITextFieldDelegate {
    
    // UI 컴포넌트 선언
    let titleLabel = UILabel()
    let idTextField = UITextField()
    let passwordTextField = UITextField()
    let loginButton = UIButton()
    let idFindButton = UIButton()
    let passwordFindButton = UIButton()
    let accountQuestionLabel = UILabel()
    let signUpButton = UIButton()
    // 눈 모양 버튼
    let eyeButton = UIButton()
    // 엑스 모양 버튼
    let clearButton = UIButton()
    
//    let setupEyeAndClearButtons = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        configureStyles()
        
        // 텍스트필드의 델리게이트를 설정
       idTextField.delegate = self
       passwordTextField.delegate = self
        
        // 초기 로그인 버튼 상태 설정 (비활성화)
        updateLoginButtonState()
        
        // 눈 모양 버튼 설정
//        setupEyeButton()
//        setupClearButton()
        
        setupEyeAndClearButtons()
        
        
        // 로그인 버튼에 대한 액션 설정
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        

    }
    
    // 텍스트 필드의 내용이 변경될 때마다 호출
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // 비동기 방식으로 텍스트 필드의 최종 텍스트 값을 가져온 뒤, 버튼 상태를 업데이트
        DispatchQueue.main.async {
            self.updateLoginButtonState()
        }
        
        return true // 텍스트 변경을 허용
    }
    
    
    // 텍스트필드가 활성화될 때 호출
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor(hex: "#9C9C9C").cgColor // Border 색상 변경
        textField.layer.borderWidth = 1.0 / UIScreen.main.scale // 1px의 두께를 설정
    }
    
    // 텍스트필드 편집이 끝났을 때 호출
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor(hex: "#2E2E2E").cgColor // 원래 색상으로 복원
        textField.layer.borderWidth = 1.0 / UIScreen.main.scale // 두께를 유지
    }
    
    // 로그인 버튼의 활성화 상태와 스타일을 업데이트하는 메서드
    private func updateLoginButtonState() {
        let isIdNotEmpty = !(idTextField.text?.isEmpty ?? true)
        let isPasswordNotEmpty = !(passwordTextField.text?.isEmpty ?? true)
        
        let isFormValid = isIdNotEmpty && isPasswordNotEmpty // 둘 다 비어있지 않아야 함.
        
        loginButton.isEnabled = isFormValid
        loginButton.backgroundColor = isFormValid ? UIColor(hex: "#FF143C") : .black // 활성화 상태에 따라 배경 색상 변경
    }
    
    private func setupEyeAndClearButtons() {
        let buttonsContainer = UIView(frame: CGRect(x: 0, y: 0, width: 76, height: 20)) // eyeButton과 clearButton을 모두 포함할 수 있는 크기
        

        // eyeButton 설정
        eyeButton.setImage(UIImage(named: "eye-closed"), for: .normal)
        eyeButton.frame = CGRect(x: 46, y: 0, width: 20, height: 20) // buttonsContainer 내에서의 위치
        eyeButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        
        // clearButton 설정
        clearButton.setImage(UIImage(named: "x-circle1"), for: .normal)
        clearButton.frame = CGRect(x: 16, y: 0, width: 20, height: 20) // buttonsContainer 내에서의 위치, 오른쪽에서 56픽셀의 위치에 eyeButton이 있으므로
        clearButton.addTarget(self, action: #selector(clearPasswordTextField), for: .touchUpInside)
        
        buttonsContainer.addSubview(eyeButton)
        buttonsContainer.addSubview(clearButton)

        passwordTextField.rightView = buttonsContainer
        passwordTextField.rightViewMode = .always
        passwordTextField.isSecureTextEntry = true
    }

    


    // 비밀번호 가시성 토글 메서드
    @objc private func togglePasswordVisibility() {
        passwordTextField.isSecureTextEntry.toggle()
        
        let imageName = passwordTextField.isSecureTextEntry ? "eye-closed" : "eye-opened"
            eyeButton.setImage(UIImage(named: imageName), for: .normal)
            eyeButton.tintColor = .clear
        
    }

    // 비밀번호 텍스트 필드를 지우는 메서드
    @objc private func clearPasswordTextField() {
        passwordTextField.text = "" // 비밀번호 텍스트 필드를 클리어합니다.
        updateLoginButtonState() // 텍스트 필드가 비어있을 때 로그인 버튼의 상태를 업데이트합니다.
    }
    
    // 로그인 버튼 클릭 시 호출되는 메서드
        @objc private func loginButtonTapped() {
            // 아이디와 비밀번호를 가져옵니다.
            guard let id = idTextField.text, let password = passwordTextField.text else {
                return
            }
            
            // WelcomeViewController를 초기화하고 아이디 데이터를 전달합니다.
            let welcomeViewController = WelcomeViewController()
            welcomeViewController.id = id
            
            // WelcomeViewController를 표시합니다.
            navigationController?.pushViewController(welcomeViewController, animated: true)
        }
        
    
    
    private func setupLayout() {
        // UI 컴포넌트들의 레이아웃을 설정합니다. (SnapKit 사용)
        // 이 부분은 앞서 제공한 코드를 기반으로 적절히 조정하면 됩니다.
        view.backgroundColor = .black
            
        // 각 UI 컴포넌트를 뷰에 추가
        view.addSubview(titleLabel)
        view.addSubview(idTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(idFindButton)
        view.addSubview(passwordFindButton)
        view.addSubview(accountQuestionLabel)
        view.addSubview(signUpButton)
            
        
        // titleLabel에 대한 SnapKit 제약 조건을 설정합니다.
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(100)
            make.centerX.equalToSuperview()
        }

        // ID TextField에 대한 SnapKit 제약 조건을 설정합니다.
        idTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.width.equalTo(335) // 너비를 335로 명시적으로 설정합니다.
            make.height.equalTo(52) // 높이를 52로 명시적으로 설정합니다.
        }
        
        // passwordTextField에 대한 SnapKit 제약 조건을 설정합니다.
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(idTextField.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.size.equalTo(idTextField)
        }

        // loginButton에 대한 SnapKit 제약 조건을 설정합니다.
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.size.equalTo(idTextField)
        }
        
        // idFindButton
        idFindButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(85) // 왼쪽에서 85 포인트 떨어지도록
        }

        // passwordFindButton
        passwordFindButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(30)
            make.trailing.equalToSuperview().inset(86) // 오른쪽에서 86 포인트 떨어지도록
        }
        
        // '아직 계정이 없으신가요?' 라벨에 대한 SnapKit 제약 조건을 설정합니다.
        accountQuestionLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordFindButton.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(51) // 화면 왼쪽에서 51만큼 떨어지도록 설정
        }

        // '닉네임 만들러가기' 버튼에 대한 SnapKit 제약 조건을 설정합니다.
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(accountQuestionLabel.snp.top)
            make.trailing.equalToSuperview().inset(50) // 화면 오른쪽에서 50만큼 떨어지도록 설정
        }
        
        
    }
    
    private func configureStyles() {
        // 각 UI 컴포넌트의 스타일을 설정합니다.

        // Title Label Style
        titleLabel.font = UIFont.systemFont(ofSize: 23)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.text = "TVING ID 로그인"

        // idTextField 스타일 설정
        idTextField.font = UIFont.systemFont(ofSize: 15)
        idTextField.backgroundColor = UIColor(hex: "#2E2E2E")
        idTextField.placeholder = "아이디" // Placeholder 설정
        idTextField.textColor = UIColor(hex: "#9C9C9C") // 텍스트 색상이 배경색과 구별되는지 확인

        // passwordTextField 스타일 설정
        passwordTextField.font = UIFont.systemFont(ofSize: 15)
        passwordTextField.backgroundColor = UIColor(hex: "#2E2E2E")
        passwordTextField.placeholder = "비밀번호" // Placeholder 설정
        passwordTextField.textColor = UIColor(hex: "#9C9C9C") // 텍스트 색상이 배경색과 구별되는지 확인

        // Login Button Style
        loginButton.setTitle("로그인하기", for: .normal)
        loginButton.backgroundColor = .black // Change this to the color you need
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIColor(hex: "#2E2E2E").cgColor
        loginButton.layer.shadowOpacity = 0.25
        loginButton.layer.shadowRadius = 4.0
        loginButton.layer.shadowOffset = CGSize(width: 0, height: 4)

        
        // idFindButton 스타일 설정
        idFindButton.setTitle("아이디 찾기", for: .normal)
        idFindButton.setTitleColor(UIColor(hex: "#9C9C9C"), for: .normal)
        idFindButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)

        // passwordFindButton 스타일 설정
        passwordFindButton.setTitle("비밀번호 찾기", for: .normal)
        passwordFindButton.setTitleColor(UIColor(hex: "#9C9C9C"), for: .normal)
        passwordFindButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)

        
        
        // Account Question Label Style
        accountQuestionLabel.text = "아직 계정이 없으신가요?"
        accountQuestionLabel.font = UIFont.systemFont(ofSize: 14)
        accountQuestionLabel.textColor = .lightGray
        
        // Sign Up Button Style
        signUpButton.setTitle("닉네임 만들러가기", for: .normal)
        signUpButton.setTitleColor(UIColor(hex: "#9C9C9C"), for: .normal)
        signUpButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        signUpButton.layer.borderWidth = 1
        signUpButton.layer.borderColor = UIColor.black.cgColor
        signUpButton.setAttributedTitle(underlinedTitle(title: "닉네임 만들러가기"), for: .normal)
    }
    
    private func underlinedTitle(title: String) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .foregroundColor: UIColor(hex: "#9C9C9C"),
            .font: UIFont.systemFont(ofSize: 14)
        ]
        return NSAttributedString(string: title, attributes: attributes)
    }
    
    // ViewController에서 viewDidAppear를 오버라이드하여 뷰의 최종 크기를 출력합니다.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let image = UIImage(named: "x-circle") {
            let imageSize = image.size
            print("Image Size: \(imageSize)")
        } else {
            print("Image not found or couldn't be loaded.")
        }

    }
    
    // 눈 모양 버튼과 엑스 모양 버튼의 위치 설정
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // 눈 모양 버튼 위치 설정
           if let eyeButton = passwordTextField.rightView as? UIButton {
               // 화면 오른쪽에서 40픽셀 떨어지도록 수정
               eyeButton.frame.origin = CGPoint(x: passwordTextField.frame.width - 60 - eyeButton.frame.width, y: (passwordTextField.frame.height - eyeButton.frame.height) / 2)
           }
           
           // 엑스 모양 버튼 위치 설정
           if let clearButton = passwordTextField.rightView as? UIButton {
               // 화면 오른쪽에서 56픽셀 떨어지도록 수정
               clearButton.frame.origin = CGPoint(x: passwordTextField.frame.width - 96 - clearButton.frame.width, y: (passwordTextField.frame.height - clearButton.frame.height) / 2)
           }

    }

    
    
}
