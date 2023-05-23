//
//  PhoneAuthView.swift
//  Arbuz-task
//
//  Created by Диас Мурзагалиев on 23.05.2023.
//

import iPhoneNumberField
import SwiftUI

struct PhoneAuthView: View {
    
    @State private var phoneNumber: String = ""
    @State private var verificationCode: String = ""
    @State private var verificationID: String?
    @State private var showVerificationAlert = false
    
    
    var body: some View {
        Group {
            VStack(spacing: 20) {
                
                Text("Для заказа подтвердите свой номер телефона")
                    .foregroundColor(.black)
                    .font(.custom("Arial", size: 20))
                    .fontWeight(.bold)
                    .padding()
                    .multilineTextAlignment(.center)
                Spacer()
                iPhoneNumberField("Номер телефона", text: $phoneNumber)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .keyboardType(.phonePad)
                
                
                
                TextField("Код из SMS", text: $verificationCode)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .keyboardType(.numberPad)
                
                Button(action: {
                    sendOTP()
                }) {
                    Text("Отправить SMS")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding(.top, 20)
                
                
                Button(action: {
                    verifyOTP()
                }) {
                    Text("Подтвердить")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(8)
                }
                .padding(.top, 20)
                Spacer()
                Spacer()
                Spacer()
            }
            .padding()
            .alert(isPresented: $showVerificationAlert) {
                Alert(
                    title: Text("Статус верификации"),
                    message: Text("SMS верификация \(verificationID != nil ? "прошла успешно" : "не пройдена")"),
                    dismissButton: .default(Text("OK"))
                )
            }
            .ignoresSafeArea(.keyboard)
        }.onTapGesture {
            hideKeyboard()
        }
    }
        
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func sendOTP() {
        
        let formattedPhoneNumber = phoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        

        let fullPhoneNumber = "+7" + formattedPhoneNumber
        
        FirebaseAuthService.shared.sendOTP(to: fullPhoneNumber) { verificationID, error in
            if let error = error {
                print("Error sending OTP: \(error.localizedDescription)")
            } else {
                verificationID.map { self.verificationID = $0 }
                print("OTP sent successfully to \(fullPhoneNumber)")
            }
        }
    }

    
    private func verifyOTP() {
        guard let verificationID = verificationID else {
            print("Verification ID not available")
            return
        }
        
        FirebaseAuthService.shared.verifyOTP(verificationID: verificationID, otp: verificationCode) { user, error in
            if let error = error {
                print("Error verifying OTP: \(error.localizedDescription)")
            } else {
                if user != nil {
                    CartViewModel.cartObj.phoneVerificationStatus = true
                    print("OTP verification successful")
                } else {
                    print("OTP verification failed")
                }
                showVerificationAlert = true
            }
        }
    }
}

struct PhoneAuthView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneAuthView()
    }
}
