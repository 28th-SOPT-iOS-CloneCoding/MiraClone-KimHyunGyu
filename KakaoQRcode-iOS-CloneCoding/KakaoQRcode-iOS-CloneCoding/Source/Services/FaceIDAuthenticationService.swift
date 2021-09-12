//
//  FaceIDAuthenticationService.swift
//  KakaoQRcode-iOS-CloneCoding
//
//  Created by kimhyungyu on 2021/09/12.
//

import Foundation
import LocalAuthentication

class FaceIDAuthenticationService {
    
    var context = LAContext()
    
    var isLoggedind = false
    
    func checkBiometryTypeFaceID() -> Bool {
        return context.biometryType == .faceID
    }
    
    func loginWithFaceID() -> Bool {
        context.localizedCancelTitle = "Enter Username/Password"

        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {

            let reason = "Log in to your account"
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason ) { success, error in

                if success {

                    // Move to the main thread because a state update triggers UI changes.
//                    DispatchQueue.main.async { [unowned self] in
//                        self.state = .loggedin
//                    }
                    self.isLoggedind = true

                } else {
                    print(error?.localizedDescription ?? "Failed to authenticate")
                    self.isLoggedind = false
                }
            }
        } else {
            print(error?.localizedDescription ?? "Can't evaluate policy")
            return false
        }
        
        return isLoggedind
    }
}
