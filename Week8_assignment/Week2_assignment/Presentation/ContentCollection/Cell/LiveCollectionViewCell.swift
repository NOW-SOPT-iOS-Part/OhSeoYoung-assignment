// LiveCollectionViewCell.swift

import UIKit
import SnapKit

/// 티빙 라이브 프로그램 컬렉션뷰 셀
final class LiveCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let identifier = "LiveCollectionViewCell"
    
    // MARK: - Components
    private let movieImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 3
        $0.clipsToBounds = true
    }
    
    private let rankLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .pretendard(weight: 700, size: 19)
        $0.textAlignment = .left
        $0.transform = CGAffineTransform(rotationAngle: CGFloat(-0.75 * .pi / 180))
        $0.frame.size = CGSize(width: 12, height: 30) // width와 height 설정
        $0.snp.makeConstraints { make in
            make.width.equalTo(12)
            make.height.equalTo(30)
        }
        $0.lineBreakMode = .byClipping 
    }
    
    private let openDateLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .pretendard(weight: 400, size: 10)
    }
    
    private let movieNameLabel = UILabel().then {
        $0.textColor = .gray9C
        $0.font = .pretendard(weight: 400, size: 10)
    }
    
    private let salesShareLabel = UILabel().then {
        $0.textColor = .gray9C
        $0.font = .pretendard(weight: 400, size: 10)
    }
    
    private let infoStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.distribution = .equalSpacing
        $0.spacing = 2
    }
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 레이아웃 설정
    private func setLayout() {
        contentView.addSubview(movieImageView)
        contentView.addSubview(rankLabel)
        contentView.addSubview(infoStackView)
        
        [openDateLabel, movieNameLabel, salesShareLabel].forEach { infoStackView.addArrangedSubview($0) }
        
        movieImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(80)
        }
        rankLabel.snp.makeConstraints {
            $0.top.equalTo(movieImageView.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(6)
            $0.width.equalTo(20)
        }
        infoStackView.snp.makeConstraints {
            $0.top.equalTo(movieImageView.snp.bottom).offset(8)
            $0.leading.equalTo(rankLabel.snp.trailing).offset(6)
            $0.trailing.equalToSuperview().offset(-6)
        }
    }
    
    // MARK: - 데이터 바인딩
    func fetchData(model: DailyBoxOffice) {
        let imageName = (Int(model.rank) ?? 0) % 2 == 0 ? "blue" : "yellow"
        movieImageView.image = UIImage(named: imageName)
        rankLabel.text = model.rank
        openDateLabel.text = model.openDt
        movieNameLabel.text = model.movieNm
        salesShareLabel.text = model.salesShare + "%"
    }
}

