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
    let privateQuestionButton = UIButton()
    
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let privatetextLabel = UILabel()
    let privateNumberLabel = UILabel()
    let timeLabel = UILabel()
    
    let qrcodeBackView = UIView()
    let qrcodeTopView = UIView()
    let qrcodeImageBackView = UIView()
    
    let privateStackView = UIStackView()
    
    
    let qrcodeImageView = QRCodeView()
    
    var isSpeechBubble = false
    var isShakeAvailable = true
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setLayout()
        setBinding()
        setNotification()
    }
}

// MARK: - Extensions

extension QRCodeViewController {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard #available(iOS 13, *) else { return }
        guard traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) else { return }
        guard traitCollection.userInterfaceStyle != previousTraitCollection?.userInterfaceStyle else { return }
        qrcodeBackView.layer.shadowColor = UIColor.shadowColor.cgColor
    }
    
    private func configUI(){
        //  다음과 같이 system color 를 사용해도 가능하다. Light 모드와 Dark 모드를 자동으로 대응해줌.
//        view.backgroundColor = .systemBackground
        // 다음과 같이 Color Assets 을 만들어서 extension 으로 정의하면 사용가능하다.
//        view.backgroundColor = .backgroundColorAsset
        view.backgroundColor = .backgroundColor
        
        titleLabel.text = "입장을 위한 QR X COOV"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabel.textColor = .defaultLabelColor
        
        subtitleLabel.text = "이용하려는 시설에 QR코드로 체크인하거나 수기명부에\n휴대전화번호 대신 개인안심번호를 기재하세요."
        subtitleLabel.font = UIFont.systemFont(ofSize: 13)
        subtitleLabel.textColor = .gray
        subtitleLabel.numberOfLines = 2
        subtitleLabel.textAlignment = .center
        
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = .defaultLabelColor
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
        
        qrcodeBackView.backgroundColor = .backgroundColor
        qrcodeBackView.layer.shadowColor = UIColor.shadowColor.cgColor
        qrcodeBackView.layer.cornerRadius = 10
        qrcodeBackView.layer.shadowRadius = 3
        qrcodeBackView.layer.shadowOpacity = 1
        qrcodeBackView.layer.shadowOffset = CGSize(width: 0, height: 0)
        qrcodeBackView.layer.masksToBounds = false
        
        qrcodeTopView.backgroundColor = #colorLiteral(red: 0.9877077937, green: 0.9827327132, blue: 0.8808727264, alpha: 1)
        qrcodeTopView.layer.cornerRadius = 10
        qrcodeTopView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        // private stack view
        privatetextLabel.text = "개인안심번호"
        privatetextLabel.font = UIFont.systemFont(ofSize: 15)
        privatetextLabel.textColor = .black

        privateQuestionButton.setImage(UIImage(systemName: "questionmark.circle.fill"), for: .normal)
        privateQuestionButton.tintColor = .gray
        privateQuestionButton.setPreferredSymbolConfiguration(.init(pointSize: 15), forImageIn: .normal)
        
        privateNumberLabel.text = "12현34규"
        privateNumberLabel.textColor = .black
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
        
        timeLabel.font = UIFont.systemFont(ofSize: 15)
        timeLabel.textColor = .gray
        viewModel.setTimeText()
    }
    
    private func setLayout() {
        
        view.addSubviews([titleLabel, subtitleLabel, closeButton, switchShakeButton, qrcodeBackView])
        qrcodeBackView.addSubviews([qrcodeTopView, qrcodeImageBackView, timeLabel])
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
        
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(qrcodeImageBackView.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func setBinding() {
        viewModel.isShakeAvailable.bind { available in
            self.isShakeAvailable = available
        }
        
        viewModel.shakeText.bind { text in
            self.switchShakeButton.setTitle(text, for: .normal)
            let attributeString = NSMutableAttributedString(string: text)
            attributeString.addAttribute(.underlineStyle , value: 1 , range: NSRange.init(location: 0, length: text.count))
            self.switchShakeButton.titleLabel?.attributedText = attributeString
        }
        
        viewModel.shakeImg.bind { image in
            self.switchShakeButton.setImage(UIImage(systemName: image), for: .normal)
        }

        viewModel.qrcodeMsg.bind { msg in
            self.qrcodeImageView.generateCode(msg, foregroundColor: .defaultLabelColor, backgroundColor: .backgroundColor)
        }
        
        viewModel.timeText.bind { time in
            let text = "남은 시간 \(time)초"
            let attributeStrring = NSMutableAttributedString(string: text)
            attributeStrring.addAttribute(.foregroundColor, value:  UIColor.red, range: NSRange.init(location: 6, length: String(time).count+1))
            self.timeLabel.attributedText = attributeStrring
        }
    }
    
    private func setNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(blockScreenShot), name: UIApplication.userDidTakeScreenshotNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(blockScreenShot), name: UIScreen.capturedDidChangeNotification, object: nil)
    }
    
    @objc
    func blockScreenShot() {
        let alert = UIAlertController(title: "캡쳐는 안돼요!", message: "보안 정책에 따라 스크린샷을 캡쳐할 수 없습니다.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

