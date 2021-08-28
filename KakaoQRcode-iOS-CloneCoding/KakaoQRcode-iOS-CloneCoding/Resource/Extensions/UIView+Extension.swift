//
//  UIView+Extension.swift
//  KakaoQRcode-iOS-CloneCoding
//
//  Created by kimhyungyu on 2021/08/28.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView])  {
        views.forEach { self.addSubview($0) }
    }
}
