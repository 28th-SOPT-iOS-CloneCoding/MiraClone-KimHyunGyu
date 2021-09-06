//
//  UserDefaults+Extension.swift
//  KakaoQRcode-iOS-CloneCoding
//
//  Created by kimhyungyu on 2021/09/06.
//

import Foundation

extension UserDefaults {
    static var shared: UserDefaults {
        let appGroupID = "group.hyun99999.KakaoQRcodeiOSCloneCoding"
        return UserDefaults(suiteName: appGroupID)!
    }
}
