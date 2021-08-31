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
    
    // presentation methods
    @objc
    func presentToQRCodeVC(_ view: UIViewController) {
        let nextVC = QRCodeViewController()
        nextVC.modalPresentationStyle = .overFullScreen
        view.present(nextVC, animated: true, completion: nil)
    }
}

