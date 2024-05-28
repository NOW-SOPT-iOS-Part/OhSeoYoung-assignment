
import Foundation
import UIKit
import Then
import SnapKit

final class MainViewController: UIViewController {

    private let scrollView = UIScrollView()
    private var contentView = UIView()
    //테이블뷰
    private let contentTableView = UITableView(frame: .zero, style: .plain)
    private let contentList = ContentModel.dummy()
    
    private let mainPoster = UIImageView()
    private let gradientView = UIImageView()
    private let gradientView2 = UIImageView()
    private let tvingLogo = UIImageView()
    private let airplay = UIButton()
    private let profile = UIImageView()
    private let explainLabel = UILabel()
    private let contentLabel = UILabel()
    private let showAll = UILabel()
    private let arrow = UIButton()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setDelegate()
//        register()
        setStyle()
        setLayout()
    }
    
    private func setLayout() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        self.view.backgroundColor = .black
  
        [mainPoster, gradientView,gradientView2, tvingLogo, airplay, profile, explainLabel,contentLabel, showAll, arrow].forEach {
            contentView.addSubview($0)
        }
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
            $0.edges.width.equalTo(scrollView)
            $0.height.greaterThanOrEqualToSuperview().priority(.low)
        }
        
        mainPoster.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(498)
        }
        gradientView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(150)
        }
        gradientView2.snp.makeConstraints {
            $0.bottom.equalTo(mainPoster.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(150)
        }
        tvingLogo.snp.makeConstraints {
            $0.top.equalTo(mainPoster.snp.top).inset(20)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(84)
            $0.height.equalTo(21)
        }
        airplay.snp.makeConstraints {
            $0.top.equalTo(profile.snp.top).offset(3)
            $0.trailing.equalTo(profile.snp.leading).offset(-25)
            $0.width.equalTo(22)
            $0.height.equalTo(16)
        }
        profile.snp.makeConstraints {
            $0.top.equalTo(mainPoster.snp.top).inset(15)
            $0.trailing.equalToSuperview().inset(16)
            $0.width.equalTo(23)
            $0.height.equalTo(23)
        }
        explainLabel.snp.makeConstraints {
            $0.bottom.equalTo(mainPoster.snp.bottom).offset(-15)
            $0.leading.equalTo(mainPoster.snp.leading).offset(10)
        }
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(mainPoster.snp.bottom).offset(43)
            $0.leading.equalToSuperview().inset(16)
        }
        arrow.snp.makeConstraints {
            $0.top.equalTo(mainPoster.snp.bottom).offset(47)
            $0.trailing.equalToSuperview().inset(14)
            $0.width.equalTo(10)
            $0.height.equalTo(10)
        }
        showAll.snp.makeConstraints {
            $0.top.equalTo(mainPoster.snp.bottom).offset(44)
            $0.trailing.equalTo(arrow.snp.leading)
        }
//        self.view.addSubview(contentTableView)
//        //테이블 뷰
//        contentTableView.snp.makeConstraints {
//            $0.top.equalTo(contentLabel.snp.bottom).offset(14)
//            $0.leading.trailing.bottom.equalToSuperview().inset(16)
//        }
      
    }
    
    private func setStyle() {
        self.navigationController?.navigationBar.isHidden = true
        
        mainPoster.do {
            $0.image = UIImage(resource: .mainPoster)
        }
        gradientView.do {
            $0.image = UIImage(resource: .gradient)
        }
        gradientView2.do {
            $0.image = UIImage(resource: .gradient2)
        }
        tvingLogo.do {
            $0.image = UIImage(resource: .tvingLogo)
        }
        airplay.do {
            $0.setImage(UIImage(resource: .airplay), for: .normal)
        }
        profile.do {
            $0.image = UIImage(resource: .profile)
            $0.layer.cornerRadius = 3
            $0.clipsToBounds = true
        }
        explainLabel.do {
            $0.text = "[추천 드라마] 한소희 존예 송강 존잘\n두번 보세요~"
            $0.textColor = UIColor.white
            $0.textAlignment = .left
            $0.numberOfLines = 2
            $0.font = UIFont(name: "Pretendard-Medium", size: 15)
        }
        contentLabel.do {
            $0.text = "티빙에서 꼭 봐야하는 콘텐츠"
            $0.textColor = .white
            $0.textAlignment = .center
            $0.font = UIFont(name: "Pretendard-Semibold", size: 17)
        }
        showAll.do {
            $0.text = "전체보기"
            $0.textColor = UIColor(resource: .gray3)
            $0.textAlignment = .center
            $0.font = UIFont(name: "Pretendard-Medium", size: 13)
        }
        arrow.do {
            $0.setImage(UIImage(resource: .arrow), for: .normal)
        }
            
    }
    
//    //테이블 뷰에 셀 등록 1.어떤 셀 등록할지 2.식별자
//    private func register() {
//        contentTableView.register(
//            ContentTableViewCell.self,
//            forCellReuseIdentifier: ContentTableViewCell.identifier
//        )
//    }
//    private func setDelegate() {
//        contentTableView.delegate = self
//        contentTableView.dataSource = self
//    }

}

//extension MainViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return tableView.frame.width // 테이블 뷰의 너비를 셀의 높이로 사용하여 가로 스크롤을 위한 높이 조절
//    }
//}

//extension MainViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 5
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContentTableViewCell.identifier, for: indexPath) as? ContentTableViewCell else { return UITableViewCell() }
//        cell.dataBind(contentList[indexPath.row])
//        return cell
//    }
//}




