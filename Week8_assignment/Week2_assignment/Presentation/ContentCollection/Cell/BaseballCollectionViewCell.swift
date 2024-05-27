import UIKit
import SnapKit

final class BaseballCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let identifier = "BaseballCollectionViewCell"
    
    // MARK: - Components
    private let baseballImageView = UIImageView().then {
        $0.image = .bearsSloganBlack
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func setLayout() {
        contentView.addSubview(baseballImageView)
        baseballImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    public func fetchData(model: BaseballSlogan) {
        baseballImageView.image = model.image
    }
}
