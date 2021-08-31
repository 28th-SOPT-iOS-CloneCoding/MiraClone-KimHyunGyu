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
    
    let qrcodeLabel = UILabel()
    let closeButton = UIButton()
    let switchShakeButton = UIButton()
    
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
        
        qrcodeLabel.text = "qrcode 입니다."
        
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = .black
        closeButton.setPreferredSymbolConfiguration(.init(pointSize: 20, weight: .regular), forImageIn: .normal)
        closeButton.addAction(UIAction { _ in
            self.viewModel.dismissToMainVC(self)
        }, for: .touchUpInside)
        
        switchShakeButton.tintColor = .darkGray
        switchShakeButton.setTitleColor(.darkGray, for: .normal)
        switchShakeButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        switchShakeButton.addAction(UIAction { _ in
            self.viewModel.setShakeAvailable()
            self.viewModel.setShakeText()
            self.viewModel.setShakeImage()
            print(self.viewModel.isShakeAvailable.value)
        }, for: .touchUpInside)
    }
    
    private func setLayout() {
        view.addSubviews([qrcodeLabel, closeButton, switchShakeButton])
        let guide = view.safeAreaLayoutGuide
        
        qrcodeLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(guide).offset(20)
            make.trailing.equalTo(guide).offset(-20)
        }
    
        switchShakeButton.snp.makeConstraints { make in
            make.bottom.equalTo(guide).offset(-20)
            make.centerX.equalToSuperview()
        }
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
        
    }
}

