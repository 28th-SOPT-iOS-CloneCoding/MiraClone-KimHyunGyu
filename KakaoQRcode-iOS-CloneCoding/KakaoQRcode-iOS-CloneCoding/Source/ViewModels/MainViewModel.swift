//
//  MainViewModel.swift
//  KakaoQRcode-iOS-CloneCoding
//
//  Created by kimhyungyu on 2021/08/26.
//

import Foundation
import UIKit

public class MainViewModel {
    
    let isShakeAvailable = Observable(true)

    func setShakeAvailable(to available: Bool) {
        self.isShakeAvailable.value = available
    }
    
    // MARK: - UserDefaults
    
    func setUserDefaults(String value: String, _ key: String) {
        UserDefaults.shared.set(value, forKey: key)
    }
    
    func setUserDefaults(UIImage value: UIImage, _ key: String) {
        let imageData = value.jpegData(compressionQuality: 1.0)
        UserDefaults.shared.set(imageData, forKey: key)
    }
    
    // MARK: - presentation methods
    
    @objc
    func presentToQRCodeVC(_ view: UIViewController) {
        let nextVC = QRCodeViewController()
        nextVC.modalPresentationStyle = .overFullScreen
        view.present(nextVC, animated: true, completion: nil)
    }
}

