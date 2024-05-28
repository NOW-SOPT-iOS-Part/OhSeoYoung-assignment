
import UIKit
import Then
import SnapKit

class ContentTableViewCell: UITableViewCell {
    //셀을 구분하기 위한 식별자
    static let identifier = "ContentTableViewCell"
    
    
    private let itemImageView = UIImageView()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
   
        self.backgroundColor = .white
        setLayout()
        setStyle()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func setStyle() {
        itemImageView.do {
            $0.image = UIImage(resource: .mainPoster)
        }
    }
    
    private func setLayout() {
        [itemImageView].forEach {
            contentView.addSubview($0)
        }
        
        itemImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(9)
            $0.bottom.equalToSuperview().inset(59)
        }
     
    }
    
}

extension ContentTableViewCell {
    func dataBind(_ contentData: ContentModel) {
        itemImageView.image = contentData.itemImg
    }
}
