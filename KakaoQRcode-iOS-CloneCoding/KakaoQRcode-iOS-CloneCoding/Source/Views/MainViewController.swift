//
//  ViewController.swift
//  KakaoQRcode-iOS-CloneCoding
//
//  Created by kimhyungyu on 2021/08/26.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    // MARK: - Properties
    let viewModel = MainViewModel()
    let mainLabel = UILabel()
    let presentToQRCodeButton = UIButton()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setLayout()
    }
}

// MARK: - Extensions

extension MainViewController {
    private func configUI(){
        view.backgroundColor = .white
        mainLabel.text = "main 입니다."
        
        presentToQRCodeButton.setTitle("qr code", for: .normal)
        presentToQRCodeButton.setTitleColor(.systemBlue, for: .normal)
        presentToQRCodeButton.addTarget(self, action: #selector(presentToQRCodeVC), for: .touchUpInside)
    }
    
    private func setLayout() {
        view.addSubviews([mainLabel, presentToQRCodeButton])
        
        mainLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        presentToQRCodeButton.snp.makeConstraints { make in
            make.top.equalTo(mainLabel).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc
    private func presentToQRCodeVC() {
        let nextVC = QRCodeViewController()
        nextVC.modalPresentationStyle = .overFullScreen
        present(nextVC, animated: true, completion: nil)
    }
}


