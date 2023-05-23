//
//  CustomTextFieldView.swift
//  Arbuz-task
//
//  Created by Диас Мурзагалиев on 23.05.2023.
//

import SwiftUI

struct CustomTextFieldView: View {
    
    @Binding var textField: String
    @Binding var isTapped: Bool
    let label: String
    
    var body: some View {
        ZStack() {
            TextField("", text: $textField) { (status) in
                if status {
                    withAnimation(.easeIn(duration: 0.15)) {
                        isTapped = true
                        
                    }
                } else if textField == "" {
                    withAnimation(.easeOut(duration: 0.15)) {
                        isTapped = false
                    }
                }
            } onCommit: {
                if textField == "" {
                    withAnimation(.easeOut(duration: 0.15)) {
                        isTapped = false
                    }
                }
            }
            .accentColor(.cyan)
            .padding(10)
            .padding(.horizontal, 7)
            .padding(.top, 15)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color(red: 0.9, green: 0.9, blue: 0.9), lineWidth: 1)
            ).padding(.vertical, 5)
                .background(
                    Text(label)
                        .font(.system(size: 14))
                        .scaleEffect($isTapped.wrappedValue ? 0.8 : 1)
                        .offset(x: $isTapped.wrappedValue ? -3 : 5, y: $isTapped.wrappedValue ? -12 : 0)
                        .foregroundColor(.gray)
                        .padding(10)
                    
                    ,alignment: .leading
                )
            if label == "Промокод" && isTapped == true {
                HStack () {
                    Spacer()
                    Button() {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    } label: {
                        Text("Применить")
                            .font(.custom("Arial", size: 15))
                            .foregroundColor(.green)
                            .fontWeight(.semibold)
                            .padding(.vertical, 5)
                    }
                    .cornerRadius(15)
                    .buttonStyle(.bordered)
                    .tint(Color(red: 162/255, green: 1, blue: 162/255))
                }.padding(.horizontal, 10)
            }
        }
    }
    
}

//struct CustomTextFieldView_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomTextFieldView()
//    }
//}
