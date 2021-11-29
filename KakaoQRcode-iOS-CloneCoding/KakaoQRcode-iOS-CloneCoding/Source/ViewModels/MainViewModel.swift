//
//  MainViewModel.swift
//  KakaoQRcode-iOS-CloneCoding
//
//  Created by kimhyungyu on 2021/08/26.
//

import Foundation

public class MainViewModel {
    
    let isShakeAvailable = Observable(true)

    func setShakeAvailable(to available: Bool) {
        self.isShakeAvailable.value = available
    }
    
    // MARK: - UserDefaults
    
    func setUserDefaults(string value: String, _ key: String) {
        UserDefaults.shared.set(value, forKey: key)
    }
    
    func setUserDefaults(data imageData: Data, _ key: String) {
        UserDefaults.shared.set(imageData, forKey: key)
    }
}

