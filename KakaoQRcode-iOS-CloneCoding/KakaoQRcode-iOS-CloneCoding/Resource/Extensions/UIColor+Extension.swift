//
//  UIColor+Extension.swift
//  KakaoQRcode-iOS-CloneCoding
//
//  Created by kimhyungyu on 2021/10/11.
//

import Foundation
import UIKit

extension UIColor {
    static let backgroundColorAsset = UIColor(named: "backgroundColorAsset")
    
//    static var backgroundColor: UIColor {
//        if #available(iOS 13.0, *) {
//            return UIColor { (traitCollection: UITraitCollection) -> UIColor in
//                if traitCollection.userInterfaceStyle == .light {
//                    return .white
//                } else {
//                    return .black
//                }
//            }
//        } else {
//            return .white
//        }
//    }
    static var backgroundColor: UIColor {
        if #available(iOS 13.0, *) {
            return .systemBackground
        } else {
            return .white
        }
    }
    
    static var defaultLabelColor: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { traitCollection in
                if traitCollection.userInterfaceStyle == .light {
                    return .black
                } else {
                    return .white
                }
            }
        } else {
            return .black
        }
    }
    
    static var reversalLabelColor: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { traitCollection in
                if traitCollection.userInterfaceStyle == .light {
                    return .white
                } else {
                    return .black
                }
            }
        } else {
            return .white
        }
    }
    
    static var shadowColor: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { traitCollection in
                if traitCollection.userInterfaceStyle == .light {
                    return .black
                } else {
                    return .red
                }
            }
        } else {
            return .black
        }
    }
}
