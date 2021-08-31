//
//  QRCodeViewController.swift
//  KakaoQRcode-iOS-CloneCoding
//
//  Created by kimhyungyu on 2021/08/30.
//

import Foundation
import UIKit

public class QRCodeViewModel {
    
    let isShakeAvailable = Observable(true)
    let shakeText = Observable("QR 체크인 쉐이크 기능 끄기")
    let shakeImg = Observable("iphone.slash")
    let qrcodeMsg = Observable("https://gyuios.tistory.com/78")
    
    func setShakeAvailable() {
        self.isShakeAvailable.value = !isShakeAvailable.value
    }
    
    func setShakeText() {
        if self.isShakeAvailable.value {
            self.shakeText.value = "QR 체크인 쉐이크 기능 끄기"
        } else {
            self.shakeText.value = "QR 체크인 쉐이크 기능 켜기"
        }
    }
    
    func setShakeImage() {
        if self.isShakeAvailable.value {
            self.shakeImg.value = "iphone.slash"
        } else {
            self.shakeImg.value = "iphone.radiowaves.left.and.right"
        }
    }
    
    func setQrcodeMsg() {
        self.qrcodeMsg.value = "https://gyuios.tistory.com/78"
    }
    
    // MARK: - presentation methods
    
    func dismissToMainVC(_ view: UIViewController) {
        view.dismiss(animated: true, completion: nil)
    }
}

