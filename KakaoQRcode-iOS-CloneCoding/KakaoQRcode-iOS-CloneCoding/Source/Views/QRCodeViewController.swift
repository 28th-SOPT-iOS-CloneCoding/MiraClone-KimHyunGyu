//
//  QRCodeViewController.swift
//  KakaoQRcode-iOS-CloneCoding
//
//  Created by kimhyungyu on 2021/08/27.
//

import UIKit
import SnapKit

class QRCodeViewController: UIViewController {

    // MARK: - Properties
    
    let viewModel = QRCodeViewModel()
    
    let closeButton = UIButton()
    let switchShakeButton = UIButton()
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let qrcodeBackView = UIView()
    let qrcodeTopView = UIView()
    let privateStackView = UIStackView()
    let privatetextLabel = UILabel()
    let privateNumberLabel = UILabel()
    let privateQuestionButton = UIButton()
    let qrcodeImageBackView = UIView()
    let qrcodeImageView = QRCodeView()
    let speechBubble = SpeechBubbleView()
    
    var isShakeAvailable = true
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setLayout()
        setBinding()
    }

}

extension QRCodeViewController {
    private func configUI(){
        view.backgroundColor = .white
        
        titleLabel.text = "입장을 위한 QR X COOV"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        
        subtitleLabel.text = "이용하려는 시설에 QR코드로 체크인하거나 수기명부에\n휴대전화번호 대신 개인안심번호를 기재하세요."
        subtitleLabel.font = UIFont.systemFont(ofSize: 13)
        subtitleLabel.textColor = .gray
        subtitleLabel.numberOfLines = 2
        subtitleLabel.textAlignment = .center
        
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = .black
        closeButton.setPreferredSymbolConfiguration(.init(pointSize: 20, weight: .regular), forImageIn: .normal)
        closeButton.addAction(UIAction { _ in
            self.viewModel.dismissToMainVC(self)
        }, for: .touchUpInside)
        
        switchShakeButton.tintColor = .gray
        switchShakeButton.setTitleColor(.gray, for: .normal)
        switchShakeButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        switchShakeButton.addAction(UIAction { _ in
            self.viewModel.setShakeAvailable()
            self.viewModel.setShakeText()
            self.viewModel.setShakeImage()
            print(self.viewModel.isShakeAvailable.value)
        }, for: .touchUpInside)
        
        qrcodeBackView.backgroundColor = .white
        qrcodeBackView.layer.cornerRadius = 10
        qrcodeBackView.layer.shadowColor = UIColor.black.cgColor
        qrcodeBackView.layer.shadowRadius = 3
        qrcodeBackView.layer.shadowOpacity = 0.1
        qrcodeBackView.layer.shadowOffset = CGSize(width: 0, height: 0)
        qrcodeBackView.layer.masksToBounds = false
        
        qrcodeTopView.backgroundColor = #colorLiteral(red: 0.9877077937, green: 0.9827327132, blue: 0.8808727264, alpha: 1)
        qrcodeTopView.layer.cornerRadius = 10
        qrcodeTopView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        // private stack view
        privatetextLabel.text = "개인안심번호"
        privatetextLabel.font = UIFont.systemFont(ofSize: 15)

        privateQuestionButton.setImage(UIImage(systemName: "questionmark.circle.fill"), for: .normal)
        privateQuestionButton.tintColor = .gray
        privateQuestionButton.setPreferredSymbolConfiguration(.init(pointSize: 15), forImageIn: .normal)
        
        privateNumberLabel.text = "12현34규"
        privateNumberLabel.font = UIFont.boldSystemFont(ofSize: 15)

        var privateViewList = [UIView]()
        privateViewList.append(contentsOf: [privatetextLabel, privateQuestionButton, privateNumberLabel])
        _ = privateViewList.map {
            privateStackView.addArrangedSubview($0)
        }
        privateStackView.axis = .horizontal
        privateStackView.spacing = 5
        privateStackView.alignment = .fill
        privateStackView.distribution = .equalSpacing
        
        // speechBubble
//        speechBubble.speechBubbleColor = .white
//        speechBubble.lineColor = .lightGray
//        speechBubble.lineWidth = 3
//        speechBubble.cornerRadius = 10
//        
//        speechBubble.triangleType = .center
//        speechBubble.triangleSpacing = 10
//        speechBubble.triangleWidth = 10
//        speechBubble.triangleHeight = 10
//        
//        speechBubble.layer.shadowColor = UIColor.black.cgColor
//        speechBubble.layer.shadowRadius = 3
//        speechBubble.layer.shadowOpacity = 0.2
//        qrcodeBackView.layer.shadowOffset = CGSize(width: 0, height: -3)
        
    }
    
    private func setLayout() {
        
        view.addSubviews([titleLabel, subtitleLabel, closeButton, switchShakeButton, qrcodeBackView, speechBubble])
        qrcodeBackView.addSubviews([qrcodeTopView, qrcodeImageBackView])
        qrcodeTopView.addSubviews([privateStackView])
        qrcodeImageBackView.addSubviews([qrcodeImageView])
        
        let guide = view.safeAreaLayoutGuide
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(guide).offset(70)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
        }

        closeButton.snp.makeConstraints {
            $0.top.equalTo(guide).offset(20)
            $0.right.equalTo(guide).offset(-20)
        }
    
        switchShakeButton.snp.makeConstraints {
            $0.bottom.equalTo(guide).offset(-20)
            $0.centerX.equalToSuperview()
        }
        
        qrcodeTopView.snp.makeConstraints {
            $0.top.left.right.equalTo(qrcodeBackView)
            $0.height.equalTo(40)
        }
        
        qrcodeBackView.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(16)
            $0.bottom.equalTo(switchShakeButton.snp.top).offset(-140)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        privateStackView.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.left.right.equalTo(qrcodeBackView).inset(80)
            $0.centerY.equalTo(qrcodeTopView)
        }
    
        qrcodeImageBackView.snp.makeConstraints {
            $0.top.equalTo(qrcodeTopView.snp.bottom).offset(16)
            $0.left.right.equalTo(qrcodeBackView).inset(60)
            $0.height.equalTo(223)
        }
        
        qrcodeImageView.snp.makeConstraints {
            $0.edges.equalTo(qrcodeImageBackView)
        }
        
//        speechBubble.snp.makeConstraints {
//            $0.bottom.equalTo(privateStackView.snp.top).offset(4)
//            $0.centerX.equalToSuperview()
//            $0.height.width.equalTo(CGSize(width: 170, height: 100))
//        }
    }
    
    private func setBinding() {
        viewModel.isShakeAvailable.bind { available in
            self.isShakeAvailable = available
        }
        
        viewModel.shakeText.bind { text in
            self.switchShakeButton.setTitle(text, for: .normal)
            let attributeString = NSMutableAttributedString(string: text)
            attributeString.addAttribute(.underlineStyle , value: "1", range: NSRange.init(location: 0, length: text.count))
            self.switchShakeButton.titleLabel?.attributedText = attributeString
        }
        
        viewModel.shakeImg.bind { image in
            self.switchShakeButton.setImage(UIImage(systemName: image), for: .normal)
        }

        viewModel.qrcodeMsg.bind { msg in
            self.qrcodeImageView.generateCode(msg)
        }
    }
}

