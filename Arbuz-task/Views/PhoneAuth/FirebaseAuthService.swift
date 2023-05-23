//
//  FirebaseAuthService.swift
//  Arbuz-task
//
//  Created by Диас Мурзагалиев on 23.05.2023.
//

import Foundation
import Firebase

class FirebaseAuthService {
    static let shared = FirebaseAuthService()
    
    private init() {}
    
    func sendOTP(to phoneNumber: String, completion: @escaping (String?, Error?) -> Void) {
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
            completion(verificationID, error)
        }
    }
    
    func verifyOTP(verificationID: String, otp: String, completion: @escaping (User?, Error?) -> Void) {
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: otp)
        
        Auth.auth().signIn(with: credential) { authResult, error in
            completion(authResult?.user, error)
        }
    }
}
