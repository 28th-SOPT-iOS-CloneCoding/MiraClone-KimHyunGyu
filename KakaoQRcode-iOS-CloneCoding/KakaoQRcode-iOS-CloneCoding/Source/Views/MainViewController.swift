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
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            print("shake began")
            presentToQRCodeVC()
        }
        
        // 조건문을 사용해서 motion 을 비교하지 않고 아래의 코드처럼 사용해도 괜찮다. 일반적으로 사용할 때는 motionShake 에 해당되기 때문이다.
        // print("shake began")
        // presentToQRCodeVC()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            print("shake ended")
        }
    }
    
    override func motionCancelled(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            print("shake cancelled")
        }
    }
}


