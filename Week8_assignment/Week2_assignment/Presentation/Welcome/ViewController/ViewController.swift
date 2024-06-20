import UIKit
import SnapKit

// MARK: - LoginView Protocol
protocol LoginViewProtocol: AnyObject {
    func updateLoginButtonState(isEnabled: Bool)
    func navigateToWelcome(with id: String)
}

let idTextField = UITextField()
let passwordTextField = UITextField()

// MARK: - LoginViewController
class ViewController: UIViewController, LoginViewProtocol, UITextFieldDelegate {
    
    var presenter: LoginPresenterProtocol?
    
    let titleLabel = UILabel()
    let loginButton = UIButton()
    let idFindButton = UIButton()
    let passwordFindButton = UIButton()
    let accountQuestionLabel = UILabel()
    let signUpButton = UIButton()
    let eyeButton = UIButton()
    let clearButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeUIComponents()
        presenter = LoginPresenter(view: self)
    }
    
    private func initializeUIComponents() {
        setupLayout()
        configureStyles()
        setupDelegates()
        setupEyeAndClearButtons()
        setupActions()
    }
    
    private func setupDelegates() {
        idTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func setupActions() {
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        presenter?.didChangeTextField(text: textField.text, for: textField)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor(hex: "#9C9C9C").cgColor
        textField.layer.borderWidth = 1.0 / UIScreen.main.scale
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor(hex: "#2E2E2E").cgColor
        textField.layer.borderWidth = 1.0 / UIScreen.main.scale
    }
    
    func updateLoginButtonState(isEnabled: Bool) {
        loginButton.isEnabled = isEnabled
        loginButton.backgroundColor = isEnabled ? UIColor(hex: "#FF143C") : .black
    }
    
    private func setupEyeAndClearButtons() {
        let buttonsContainer = UIView(frame: CGRect(x: 0, y: 0, width: 76, height: 20))
        
        eyeButton.setImage(UIImage(named: "eye-closed"), for: .normal)
        eyeButton.frame = CGRect(x: 46, y: 0, width: 20, height: 20)
        eyeButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        
        clearButton.setImage(UIImage(named: "x-circle1"), for: .normal)
        clearButton.frame = CGRect(x: 16, y: 0, width: 20, height: 20)
        clearButton.addTarget(self, action: #selector(clearPasswordTextField), for: .touchUpInside)
        
        buttonsContainer.addSubview(eyeButton)
        buttonsContainer.addSubview(clearButton)
        
        passwordTextField.rightView = buttonsContainer
        passwordTextField.rightViewMode = .always
        passwordTextField.isSecureTextEntry = true
    }
    
    @objc private func togglePasswordVisibility() {
        passwordTextField.isSecureTextEntry.toggle()
        
        let imageName = passwordTextField.isSecureTextEntry ? "eye-closed" : "eye-opened"
        eyeButton.setImage(UIImage(named: imageName), for: .normal)
        eyeButton.tintColor = .clear
    }
    
    @objc private func clearPasswordTextField() {
        passwordTextField.text = ""
        presenter?.didChangeTextField(text: passwordTextField.text, for: passwordTextField)
    }
    
    @objc private func loginButtonTapped() {
        presenter?.didTapLoginButton(id: idTextField.text, password: passwordTextField.text)
    }
    
    private func setupLayout() {
        view.backgroundColor = .black
        
        view.addSubview(titleLabel)
        view.addSubview(idTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(idFindButton)
        view.addSubview(passwordFindButton)
        view.addSubview(accountQuestionLabel)
        view.addSubview(signUpButton)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(100)
            make.centerX.equalToSuperview()
        }
        
        idTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.width.equalTo(335)
            make.height.equalTo(52)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(idTextField.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.size.equalTo(idTextField)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.size.equalTo(idTextField)
        }
        
        idFindButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(85)
        }
        
        passwordFindButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(30)
            make.trailing.equalToSuperview().inset(86)
        }
        
        accountQuestionLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordFindButton.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(51)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(accountQuestionLabel.snp.top)
            make.trailing.equalToSuperview().inset(50)
        }
    }
    
    private func configureStyles() {
        titleLabel.font = UIFont.systemFont(ofSize: 23)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.text = "TVING ID 로그인"
        
        idTextField.font = UIFont.systemFont(ofSize: 15)
        idTextField.backgroundColor = UIColor(hex: "#2E2E2E")
        idTextField.placeholder = "아이디"
        idTextField.textColor = UIColor(hex: "#9C9C9C")
        
        passwordTextField.font = UIFont.systemFont(ofSize: 15)
        passwordTextField.backgroundColor = UIColor(hex: "#2E2E2E")
        passwordTextField.placeholder = "비밀번호"
        passwordTextField.textColor = UIColor(hex: "#9C9C9C")
        
        loginButton.setTitle("로그인하기", for: .normal)
        loginButton.backgroundColor = .black
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIColor(hex: "#2E2E2E").cgColor
        loginButton.layer.shadowOpacity = 0.25
        loginButton.layer.shadowRadius = 4.0
        loginButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        
        idFindButton.setTitle("아이디 찾기", for: .normal)
        idFindButton.setTitleColor(UIColor(hex: "#9C9C9C"), for: .normal)
        idFindButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        
        passwordFindButton.setTitle("비밀번호 찾기", for: .normal)
        passwordFindButton.setTitleColor(UIColor(hex: "#9C9C9C"), for: .normal)
        passwordFindButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        
        accountQuestionLabel.text = "아직 계정이 없으신가요?"
        accountQuestionLabel.font = UIFont.systemFont(ofSize: 14)
        accountQuestionLabel.textColor = .lightGray
        
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let image = UIImage(named: "x-circle") {
            let imageSize = image.size
            print("Image Size: \(imageSize)")
        } else {
            print("Image not found or couldn't be loaded.")
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let eyeButton = passwordTextField.rightView as? UIButton {
            eyeButton.frame.origin = CGPoint(x: passwordTextField.frame.width - 60 - eyeButton.frame.width, y: (passwordTextField.frame.height - eyeButton.frame.height) / 2)
        }
        
        if let clearButton = passwordTextField.rightView as? UIButton {
            clearButton.frame.origin = CGPoint(x: passwordTextField.frame.width - 96 - clearButton.frame.width, y: (passwordTextField.frame.height - clearButton.frame.height) / 2)
        }
    }
    
    // MARK: - LoginViewProtocol
    func navigateToWelcome(with id: String) {
        let welcomeViewController = WelcomeViewController()
        welcomeViewController.presenter = WelcomePresenter(view: welcomeViewController, userService: UserService())
        welcomeViewController.id = id
        navigationController?.pushViewController(welcomeViewController, animated: true)
    }
}

// MARK: - LoginPresenter Protocol
protocol LoginPresenterProtocol {
    func didTapLoginButton(id: String?, password: String?)
    func didChangeTextField(text: String?, for textField: UITextField)
}

// MARK: - LoginPresenter
class LoginPresenter: LoginPresenterProtocol {
    
    weak var view: LoginViewProtocol?
    
    init(view: LoginViewProtocol) {
        self.view = view
    }
    
    func didTapLoginButton(id: String?, password: String?) {
        guard let id = id, !id.isEmpty, let password = password, !password.isEmpty else {
            view?.updateLoginButtonState(isEnabled: false)
            return
        }
        view?.navigateToWelcome(with: id)
    }
    
    func didChangeTextField(text: String?, for textField: UITextField) {
        guard let idText = idTextField.text, let passwordText = passwordTextField.text else {
            return
        }
        
        let isIdNotEmpty = !idText.isEmpty
        let isPasswordNotEmpty = !passwordText.isEmpty
        let isFormValid = isIdNotEmpty && isPasswordNotEmpty
        view?.updateLoginButtonState(isEnabled: isFormValid)
    }
}
