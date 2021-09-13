//
//  FaceIDAuthenticationViewController.swift
//  KakaoQRcode-iOS-CloneCoding
//
//  Created by kimhyungyu on 2021/09/12.
//

import UIKit
import LocalAuthentication

class FaceIDAuthenticationViewController: UIViewController {

    let faceIDButton = UIButton()
    
    let viewModel = FaceIDAuthenticationViewModel()
    let service = FaceIDAuthenticationService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setLayout()
        setBinding()
        setFaceIDAuthentication()
    }
}

// MARK: - Extensions

extension FaceIDAuthenticationViewController {
    private func configUI() {
        view.backgroundColor = .white
        
        faceIDButton.setTitle("", for: .normal)
        faceIDButton.setImage(UIImage(systemName: "faceid"), for: .normal)
        faceIDButton.tintColor = .black
        faceIDButton.setPreferredSymbolConfiguration(.init(pointSize: 40, weight: .light), forImageIn: .normal)
        faceIDButton.addAction(UIAction { _ in
            self.service.loginWithFaceID()
        }, for: .touchUpInside)
    }
    
    private func setLayout() {
        view.addSubviews([faceIDButton])
        
        faceIDButton.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    private func setBinding() {

    }
    
    private func setFaceIDAuthentication() {
        faceIDButton.isHidden = service.checkBiometryTypeFaceID()
        service.loginWithFaceID()
    }
}
