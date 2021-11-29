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

// UTType 를 사용하기 위해서
import UniformTypeIdentifiers

class MainViewController: UIViewController {
    
    // MARK: - Properties
    let viewModel = MainViewModel()

    let mainLabel = UILabel()
    let nameLabel = UILabel()
    
    let profileImage = UIImageView()
    
    let qrCodeButton = UIButton()
    let activityButton = UIButton()
    
    let textView = UITextView()
    
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
        
        qrCodeButton.setTitle("qr code", for: .normal)
        qrCodeButton.setTitleColor(.systemBlue, for: .normal)
        qrCodeButton.addTarget(self, action: #selector(presentToQRCodeVC), for: .touchUpInside)
        
        textView.text = "변경 전"
        textView.textAlignment = .center
        
        activityButton.setTitle("", for: .normal)
        activityButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        activityButton.addTarget(self, action: #selector(presentToActivityVC), for: .touchUpInside)
    }
    
    private func setLayout() {
        view.addSubviews([mainLabel, nameLabel, profileImage, qrCodeButton, textView, activityButton])
        
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
        
        qrCodeButton.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        textView.snp.makeConstraints {
            $0.top.equalTo(qrCodeButton.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(CGSize(width: 100, height: 30))
        }
        
        activityButton.snp.makeConstraints {
            $0.top.equalTo(textView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        
    }
    
    private func setUserDefaults() {
        if let nameLabel = nameLabel.text {
            viewModel.setUserDefaults(string: nameLabel, "Name")
        }
        if let profileImage = profileImage.image, let imageData = profileImage.jpegData(compressionQuality: 1.0) {
            viewModel.setUserDefaults(data: imageData, "ProfileImage")
        }
    }
    
    // MARK: - presentation methods
    
    @objc
    private func presentToQRCodeVC() {
        let nextVC = QRCodeViewController()
        nextVC.modalPresentationStyle = .overFullScreen
        present(nextVC, animated: true, completion: nil)
    }
    
    @objc private func presentToActivityVC() {
        let activityViewController = UIActivityViewController(activityItems: [textView.text ?? ""], applicationActivities: nil)
        
        // ✅ 기본제공 서비스 중 사용하지 않을 ActivityType 제거할 수 있다.(에어드랍 제거)
//        activityViewController.excludedActivityTypes = [UIActivity.ActivityType.airDrop]

        // ✅ activity 가 완료되거나 activity view controller 가 해제되면 completion block 이 실행.
        activityViewController.completionWithItemsHandler = { activity, success, items, error in
            if success {
                print("activity: \(activity)")
                print("item: \(items)")
                
                guard let textItem = items?.first as? NSExtensionItem, let itemProvider = textItem.attachments?.first else { return }
                if itemProvider.hasItemConformingToTypeIdentifier(UTType.text.identifier) {
                    itemProvider.loadItem(forTypeIdentifier: UTType.text.identifier, options: nil) { item, error in
                        DispatchQueue.main.async {
                            self.textView.text = item as? String
                        }
                    }
                }
            } else {
                print(error)
           }
        }
        self.present(activityViewController, animated: true, completion: nil)
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


