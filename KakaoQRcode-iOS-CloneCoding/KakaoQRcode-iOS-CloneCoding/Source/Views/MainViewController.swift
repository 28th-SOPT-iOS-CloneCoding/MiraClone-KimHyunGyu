//
//  ViewController.swift
//  KakaoQRcode-iOS-CloneCoding
//
//  Created by kimhyungyu on 2021/08/26.
//

import UIKit
import SnapKit
// CMMotionMager 를 사용하기 위해서
import CoreMotion
// AudioServicesPlaySystemSound(_:) 메서드를 사용하기 위해서
import AudioToolbox

class MainViewController: UIViewController {
    
    // MARK: - Properties
    let viewModel = MainViewModel()

    let mainLabel = UILabel()
    let nameLabel = UILabel()
    
    let profileImage = UIImageView()
    
    let presentToQRCodeButton = UIButton()
    
    var motionNumber = 0
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setLayout()
        setUserDefaults()
        
        // UIKit 이 이 object 를 window 에서 first responder 로 만들도록 한다.
        becomeFirstResponder()
        
        /*
        let coreMotionManager = CMMotionManager()
        getDeviceMotion(coreMotionMager: coreMotionManager)
         */
    }
}

// MARK: - Extensions

extension MainViewController {
    
    private func configUI(){
        view.backgroundColor = .backgroundColor
        mainLabel.text = "main 입니다."
        mainLabel.textColor = .defaultLabelColor
        
        nameLabel.text = "김현규"
        nameLabel.textColor = .defaultLabelColor
        
        if let image = UIImage(named: "profileImage") {
            profileImage.image = image
        }
        profileImage.contentMode = .scaleAspectFill
        
        presentToQRCodeButton.setTitle("qr code", for: .normal)
        presentToQRCodeButton.setTitleColor(.systemBlue, for: .normal)
        presentToQRCodeButton.addTarget(self, action: #selector(presentToQRCodeVC), for: .touchUpInside)
    }
    
    private func setLayout() {
        view.addSubviews([mainLabel, nameLabel, profileImage, presentToQRCodeButton])
        
        mainLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(200)
        }
        
        profileImage.snp.makeConstraints {
            $0.top.equalTo(mainLabel.snp.bottom).offset(20)
            $0.size.equalTo(CGSize(width: 200, height: 300))
            $0.centerX.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(profileImage.snp.bottom).offset(20)
        }
        
        presentToQRCodeButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(100)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func setUserDefaults() {
        if let nameLabel = nameLabel.text {
            viewModel.setUserDefaults(String: nameLabel, "Name")
        }
        if let profileImage = profileImage.image {
            viewModel.setUserDefaults(UIImage: profileImage, "ProfileImage")
        }
    }
    
    
    @objc
    private func presentToQRCodeVC() {
        viewModel.presentToQRCodeVC(self)
    }
    
    /*
// **shake motion detect with CMMotionMager**
    
    private func getDeviceMotion(coreMotionMager: CMMotionManager) {
        if coreMotionMager.isDeviceMotionAvailable {
            coreMotionMager.deviceMotionUpdateInterval = 1
            coreMotionMager.startDeviceMotionUpdates(to: .main
            ) { _, _  in
                print("shake")
                // qrcode 뷰가 dismiss 되더라도 motion은 계속 update 되야하기 때문에 stop 메서드를 주석처리해주었다.
//                coreMotionMager.stopDeviceMotionUpdates()
                self.presentToQRCodeVC()
            }
        }
    }
 */
    
// **shake motion detect with UIResponder**
    
    // responder 는 자신이 first responder 가 될 수 있게 하기 위해서 canBecomeFirstResponder 프로퍼티를 오버라이드해서 ture 를 리턴하도록 만들어야 한다.
    // UIView 는 UIResponder 의 상속을 받기 때문에 아래와 같이 재정의할 수 있는 이유가 된다.

    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            print("shake began")
        }
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            print("shake ended")
            motionNumber += 1
            print("motionNumber: \(motionNumber)")
            
            let isShakeAvailable = viewModel.isShakeAvailable.value
            if motionNumber == 2 && isShakeAvailable {
                motionNumber = 0
                presentToQRCodeVC()
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            }
        }
    }
    
    override func motionCancelled(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            print("shake cancelled")
            motionNumber = 0
        }
    }
}


