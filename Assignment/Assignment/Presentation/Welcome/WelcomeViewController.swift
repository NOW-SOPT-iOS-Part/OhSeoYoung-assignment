//
//  WelcomeViewController.swift
//  Assignment
//
//  Created by 오서영 on 6/21/24.
//
import UIKit
import SnapKit
import SwiftUI

protocol DataBindProtocol: AnyObject {
    func updateBorderColor(for textField: UITextField, isActive: Bool)
    func dataBind(id: String)
}

final class WelcomeViewController: UIViewController {
    
    weak var delegate: DataBindProtocol?
    
    private var id: String?
        
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "tvingLogo")
        return imageView
    }()
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "???님 \n반가워요!"
        label.font = UIFont(name: "Pretendard-ExtraBold", size: 25)
        label.textColor = UIColor(named: "white")
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    private var goHomeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "red")
        button.setTitle("메인으로", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 18)
        button.addTarget(self, action: #selector(goHomeButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private func bindID() {
        guard let idText = id else { return }
        self.welcomeLabel.text = "\(idText)님 \n반가워요!"
    }
    
    func setLabelText(id: String?) {
        self.id = id
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
        setLayout()
        
        bindID()
    }
    
    private func setLayout() {
        [logoImageView, welcomeLabel, goHomeButton].forEach {
            self.view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        logoImageView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalToSuperview().offset(58)
            make.height.equalTo(210)
        }
        
        welcomeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(logoImageView.snp.bottom).offset(67)
        }
        
        goHomeButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(welcomeLabel.snp.bottom).offset(284)
            make.height.equalTo(52)
        }

    }
    
    @objc
    private func backToLoginButtonDidTap() {
        if let id = id {
            delegate?.dataBind(id: id)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func goHomeButtonDidTap() {
        let mainViewController = MainViewController()
        self.navigationController?.pushViewController(mainViewController, animated: true)
    }

}

// 프리뷰를 위한 코드
struct WelcomeViewController_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeViewControllerRepresentable()
            .edgesIgnoringSafeArea(.all)
    }
}

struct WelcomeViewControllerRepresentable: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> WelcomeViewController {
        WelcomeViewController()
    }
    
    func updateUIViewController(_ uiViewController: WelcomeViewController, context: Context) {
        
    }
}

// MARK: - Preview Layout Customization
extension WelcomeViewController_Previews {
    static var platform: PreviewPlatform? = .iOS
    static var devices: [String] = ["iPhone 15 Pro"]
}
