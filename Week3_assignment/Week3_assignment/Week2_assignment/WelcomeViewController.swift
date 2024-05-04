//
//  WelcomeViewController.swift
//  Week2_assignment
//
//  Created by 오서영 on 2024/04/10.
//

import Foundation

import UIKit
import SnapKit

class WelcomeViewController: UIViewController {
    
    var id: String?
    
    // MARK: - Properties
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "tving_logo") // This references the logo stored in Assets
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "nowsopt@naver.com 님\n반가워요!" // Placeholder text
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0 // Allows for multiple lines
        label.textColor = UIColor(hex: "#D6D6D6") // Set the color to #D6D6D6
        return label
    }()
    
    private let mainButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("메인으로", for: .normal)
        button.backgroundColor = UIColor(hex: "#FF143C") // The button color
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 0
        button.clipsToBounds = true
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    // MARK: - Setup
    private func setupLayout() {
        view.backgroundColor = .black
        
        // Adding subviews
        view.addSubview(logoImageView)
        view.addSubview(welcomeLabel)
        view.addSubview(mainButton)
        
        // Logo ImageView Constraints
                logoImageView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                    logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    logoImageView.widthAnchor.constraint(equalToConstant: 375),
                    logoImageView.heightAnchor.constraint(equalToConstant: 210.94)
                ])
                
                // Welcome Label Constraints
                welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    welcomeLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 67), // Adjust the constant as needed
                    welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                    welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
                ])
                
                // Main Button Constraints
                mainButton.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    mainButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -66),
                    mainButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    mainButton.widthAnchor.constraint(equalToConstant: 335),
                    mainButton.heightAnchor.constraint(equalToConstant: 52)
                ])
    }
    
    // MARK: - Actions
        @objc private func didTapMainButton() {
            // MainViewController 인스턴스 생성
            let mainViewController = MainViewController()
            
            // 네비게이션 컨트롤러를 사용해 MainViewController로 화면 전환
            navigationController?.pushViewController(mainViewController, animated: true)
        }
    
    // Add this function to handle the main button tap
       override func viewDidLayoutSubviews() {
           super.viewDidLayoutSubviews()
           mainButton.addTarget(self, action: #selector(didTapMainButton), for: .touchUpInside)
       }
        
}

// Extension for UIColor to convert hex color to UIColor
extension UIColor {
   convenience init(hex: String) {
       var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
       hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
       
       var rgb: UInt64 = 0
       
       Scanner(string: hexSanitized).scanHexInt64(&rgb)
       
       let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
       let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
       let blue = CGFloat(rgb & 0x0000FF) / 255.0
       let alpha = CGFloat(1.0)
       
       self.init(red: red, green: green, blue: blue, alpha: alpha)
   }
}
