//
//  FaceIDAuthenticationService.swift
//  KakaoQRcode-iOS-CloneCoding
//
//  Created by kimhyungyu on 2021/09/12.
//

import Foundation
import UIKit
import LocalAuthentication

class FaceIDAuthenticationService {
    
    var context = LAContext()
    
    enum AuthenticationState {
        case loggedin, loggedout
    }
    
    var state = AuthenticationState.loggedout
    
    // 장비가 가능한지 묻는 것
    func checkBiometryTypeFaceID() -> Bool {
        return context.biometryType == .faceID
    }
    
    func loginWithFaceID() {
        context.localizedCancelTitle = "Enter Username/Password"

        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {

            let reason = "Log in to your account"
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason ) { success, error in

                if success {
                    // Move to the main thread because a state update triggers UI changes.
                    DispatchQueue.main.async { [unowned self] in
                        self.state = .loggedin
                        NotificationCenter.default.post(name: NSNotification.Name("presentToMainVC"), object: nil)
                    }
                } else {
                    print(error?.localizedDescription ?? "Failed to authenticate")
                }
            }
        } else {
            print(error?.localizedDescription ?? "Can't evaluate policy")
        }
    }
}
