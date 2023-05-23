//
//  TipsModelView.swift
//  Arbuz-task
//
//  Created by Диас Мурзагалиев on 23.05.2023.
//

import SwiftUI

struct TipsModelView: View {
    @Binding var isShowing: Bool
    @Binding var tip: Int
    @Binding var textfield: String
    
    @State var isTipsTapped = false
    var body: some View {
        
            VStack(spacing: 15) {
                Text("Чаевые")
                    .font(.custom("Arial", size: 22))
                    .fontWeight(.semibold).foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, 8)
                CustomTextFieldView(textField: $textfield, isTapped: $isTipsTapped, label: "Введите сумму от 0 ₸ до 5000 ₸").keyboardType(.decimalPad)
                Button() {
                    tip = Int(textfield) ?? 0
                    isShowing = false
                } label: {
                    Spacer()
                    Text("Оставить")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .padding(.vertical, 10)
                    Spacer()
                }
                .background(.green)
                .cornerRadius(15)
                .buttonStyle(.bordered)
                
                Button() {
                    isShowing = false
                } label: {
                    Spacer()
                    Text("Отмена")
                        .foregroundColor(.green)
                        .fontWeight(.semibold)
                        .padding(.vertical, 10)
                    Spacer()
                }
                .background(Color(red: 242/255, green: 1, blue: 242/255))
                .cornerRadius(15)
                .buttonStyle(.bordered)
            }
            .padding(.horizontal, 23)
        }
}

//struct TipsModelView_Previews: PreviewProvider {
//    static var previews: some View {
//        TipsModelView()
//    }
//}
