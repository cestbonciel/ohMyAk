//
//  MoreMenuView.swift
//  SoundLog
//
//  Created by Nat Kim on 2023/12/02.
//
import UIKit
import SnapKit

class MoreMenuView: UIView {
    var myIntrinsicSize: CGSize = .zero
    override var intrinsicContentSize: CGSize {
        return myIntrinsicSize
    }
    
    private lazy var introLabel: UILabel = {
        let label = UILabel()
        label.font = .gmsans(ofSize: 12, weight: .GMSansMedium)
        label.text = "당신을 위한 소리 기록장"
        label.textColor = .systemDimGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nicknameStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [userNickname, modifiedButton])
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var bookmarkStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [bookmarkIcon, bookmarkLabel])
        stackView.axis = .horizontal
        stackView.alignment = .firstBaseline
//        stackView.isLayoutMarginsRelativeArrangement = true
//        stackView.layoutMargins = UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var userNickname: UILabel = {
        let label = UILabel()
        label.font = .gmsans(ofSize: 16, weight: .GMSansMedium)
        label.text = "뮤덕이" //나중에 사용자 닉네임 값 받아오는 걸로 변경해야함
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var modifiedButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 48, height: 0)
        button.contentEdgeInsets = .init(top: 0, left: 8, bottom: 0, right: 8)
        button.layer.cornerRadius = 10
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.lightGray
        button.titleLabel?.font = .gmsans(ofSize: 16, weight: .GMSansMedium)
        button.heightAnchor.constraint(equalToConstant: 24).isActive = true
        button.setTitle("변경", for: .normal)
        return button
    }()
    
    
    private lazy var bookmarkLabel: UILabel = {
        let label = UILabel()
        label.font = .gmsans(ofSize: 16, weight: .GMSansMedium)
        label.text = "북마크"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var bookmarkIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "bookmarkIcon")
        
        icon.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.addSubview(introLabel)
        self.addSubview(nicknameStack)
        self.addSubview(bookmarkStack)
        introLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(120)
            $0.left.right.equalToSuperview().offset(30)
        }
        
        nicknameStack.snp.makeConstraints {
            $0.top.equalTo(introLabel.snp.bottom).offset(42)
            $0.left.right.equalToSuperview().inset(24)
            $0.height.equalTo(51)
        }
        
        userNickname.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        modifiedButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
//            $0.top.bottom.equalTo(nicknameStack.snp.top).inset(8)
//            $0.height.equalTo(16)
        }
        bookmarkStack.snp.makeConstraints {
            $0.top.equalTo(nicknameStack.snp.bottom).offset(24)
            $0.left.equalToSuperview().inset(24)
            $0.height.equalTo(51)
        }
//        bookmarkIcon.setContentCompressionResistancePriority(.init(1000), for: .horizontal)
//        bookmarkIcon.setContentHuggingPriority(.init(251), for: .horizontal)
        
        bookmarkIcon.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.height.equalTo(32)
        }
        bookmarkLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
            
        }
        
    }
}
