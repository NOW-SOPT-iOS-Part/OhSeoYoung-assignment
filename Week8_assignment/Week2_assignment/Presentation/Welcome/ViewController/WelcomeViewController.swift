import UIKit
import SnapKit

// MARK: - WelcomeView Protocol
protocol WelcomeViewProtocol: AnyObject {
    func setWelcomeMessage(_ message: String)
    func navigateToMain()
}

// MARK: - WelcomeViewController
class WelcomeViewController: UIViewController, WelcomeViewProtocol {
    
    var presenter: WelcomePresenterProtocol?
    var id: String?
    
    // MARK: - Properties
    private let logoImageView = UIImageView()
    private let welcomeLabel = UILabel()
    private let mainButton = UIButton(type: .system)
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupStyles()
        setupActions()
        presenter?.viewDidLoad()
    }
    
    // MARK: - Setup
    private func setupLayout() {
        view.backgroundColor = .black
        
        view.addSubview(logoImageView)
        view.addSubview(welcomeLabel)
        view.addSubview(mainButton)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 375),
            logoImageView.heightAnchor.constraint(equalToConstant: 210.94)
        ])
        
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 67),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        mainButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -66),
            mainButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainButton.widthAnchor.constraint(equalToConstant: 335),
            mainButton.heightAnchor.constraint(equalToConstant: 52)
        ])
    }
    
    private func setupStyles() {
        logoImageView.image = UIImage(named: "tving_logo")
        logoImageView.contentMode = .scaleAspectFit
        
        welcomeLabel.textAlignment = .center
        welcomeLabel.font = UIFont.systemFont(ofSize: 18)
        welcomeLabel.numberOfLines = 0
        welcomeLabel.textColor = UIColor(hex: "#D6D6D6")
        
        mainButton.setTitle("메인으로", for: .normal)
        mainButton.backgroundColor = UIColor(hex: "#FF143C")
        mainButton.setTitleColor(.white, for: .normal)
        mainButton.layer.cornerRadius = 0
        mainButton.clipsToBounds = true
    }
    
    // MARK: - Actions
    private func setupActions() {
        mainButton.addTarget(self, action: #selector(didTapMainButton), for: .touchUpInside)
    }

    @objc private func didTapMainButton() {
        presenter?.didTapMainButton()
    }
    
    // MARK: - WelcomeViewProtocol
    func setWelcomeMessage(_ message: String) {
        welcomeLabel.text = message
    }

    func navigateToMain() {
        let mainViewController = MainViewController()
        navigationController?.pushViewController(mainViewController, animated: true)
    }
}

// MARK: - WelcomePresenter Protocol
protocol WelcomePresenterProtocol {
    func viewDidLoad()
    func didTapMainButton()
}

// MARK: - WelcomePresenter
class WelcomePresenter: WelcomePresenterProtocol {
    weak var view: WelcomeViewProtocol?
    private let userService: UserServiceProtocol
    
    init(view: WelcomeViewProtocol, userService: UserServiceProtocol) {
        self.view = view
        self.userService = userService
    }
    
    func viewDidLoad() {
        if let userId = userService.getUserId() {
            view?.setWelcomeMessage("\(userId)님\n반가워요!")
        }
    }
    
    func didTapMainButton() {
        view?.navigateToMain()
    }
}

// MARK: - UserService Protocol
protocol UserServiceProtocol {
    func getUserId() -> String?
}

// MARK: - UserService
class UserService: UserServiceProtocol {
    func getUserId() -> String? {
        // 사용자 ID 반환 로직
        return "nowsopt@naver.com"
    }
}
