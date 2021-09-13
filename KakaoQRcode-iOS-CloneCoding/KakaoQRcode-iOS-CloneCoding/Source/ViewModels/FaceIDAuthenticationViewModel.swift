//
//  FaceIDAuthenticationViewModel.swift
//  KakaoQRcode-iOS-CloneCoding
//
//  Created by kimhyungyu on 2021/09/12.
//

import Foundation

enum AuthenticationState {
    case loggedin, loggedout
}

class FaceIDAuthenticationViewModel {
    private let faceIDAuthenticationService = FaceIDAuthenticationService()
    
    let loggedState = Observable(AuthenticationState.loggedout)
    let isFaceIDButtonHidden = Observable(true)
    
    
    func setFaceIDButton() {
        if faceIDAuthenticationService.checkBiometryTypeFaceID() {
            self.isFaceIDButtonHidden.value = false
        } else {
            self.isFaceIDButtonHidden.value = true
        }
        print(faceIDAuthenticationService.checkBiometryTypeFaceID())
    }
    
    func setLoginWithFaceID() -> Bool {
        return faceIDAuthenticationService.loginWithFaceID()
    }
}
