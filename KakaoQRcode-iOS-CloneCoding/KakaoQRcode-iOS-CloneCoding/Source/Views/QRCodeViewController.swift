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
    
    let qrcodeLabel = UILabel()
    let closeButton = UIButton()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setLayout()
    }

}

extension QRCodeViewController {
    private func configUI(){
        view.backgroundColor = .white
        
        qrcodeLabel.text = "qrcode 입니다."
        
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = .black
        closeButton.setPreferredSymbolConfiguration(.init(pointSize: 20, weight: .regular), forImageIn: .normal)
        closeButton.addTarget(self, action: #selector(dismisssToMain), for: .touchUpInside)
    }
    
    func setLayout() {
        view.addSubviews([qrcodeLabel, closeButton])
        let guide = view.safeAreaLayoutGuide
        qrcodeLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(guide).offset(20)
            make.trailing.equalTo(guide).offset(-20)
        }
    }
    
    @objc
    func dismisssToMain() {
        dismiss(animated: true, completion: nil)
    }
}

