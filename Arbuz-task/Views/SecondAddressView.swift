//
//  SecondAddressView.swift
//  Arbuz-task
//
//  Created by Диас Мурзагалиев on 23.05.2023.
//

import SwiftUI

struct SecondAddressView: View {
    @Environment(\.presentationMode) private var presentationMode
    
    @State private var isStreetTapped = false
    @State private var isFlatTapped = false
    @State private var isEntranceTapped = false
    @State private var isFloorTapped = false
    
    @State private var street = ""
    @State private var flat = ""
    @State private var entrance = ""
    @State private var floor = ""
    
    var cartViewModel = CartViewModel.cartObj
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Город")
                        .font(.custom("Arial", size: 13))
                        .foregroundColor(.gray)
                    Text("Астана")
                        .font(.custom("Arial", size: 15))
                        .foregroundColor(.gray)
                }.padding(10)
                Spacer()
            }
                .background(Color(red: 0.98, green: 0.98, blue: 0.98))
                .cornerRadius(12)
            
            CustomTextField(textField: $street, isTapped: $isStreetTapped, label: "Улица и номер дома")
            HStack(spacing: 15) {
                CustomTextField(textField: $flat, isTapped: $isFlatTapped, label: "Квартира")
                    .keyboardType(.decimalPad)
                CustomTextField(textField: $entrance, isTapped: $isEntranceTapped, label: "Подъезд")
                    .keyboardType(.decimalPad)
                CustomTextField(textField: $floor, isTapped: $isFloorTapped, label: "Этаж")
                    .keyboardType(.decimalPad)
            }
            Spacer()
            Image("addressBg")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(-15)
            Spacer()
            Button() {
                cartViewModel.addresses.append("\(street), кв \(flat), подъезд \(entrance), этаж \(floor)")
                presentationMode.wrappedValue.dismiss()
            } label: {
                Spacer()
                Text("Подтвердить адрес")
                    .foregroundColor(.white)
                    .font(.custom("Arial", size: 15))
                    .fontWeight(.semibold)
                    .padding(.vertical, 10)
                Spacer()
            }
            .background(.green)
            .cornerRadius(15)
            .buttonStyle(.bordered)
        }
        .padding(15)
        .ignoresSafeArea(.keyboard)
        .onTapGesture {
            hideKeyboard()
        }
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    @ViewBuilder func CustomTextField(textField: Binding<String>, isTapped: Binding<Bool>, label: String) -> some View {
        ZStack() {
            TextField("", text: textField) { (status) in
                if status {
                    withAnimation(.easeIn(duration: 0.15)) {
                        isTapped.wrappedValue = true
                        
                    }
                } else if textField.wrappedValue == "" {
                    withAnimation(.easeOut(duration: 0.15)) {
                        isTapped.wrappedValue = false
                    }
                }
            } onCommit: {
                if textField.wrappedValue == "" {
                    withAnimation(.easeOut(duration: 0.15)) {
                        isTapped.wrappedValue = false
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
                        .scaleEffect(isTapped.wrappedValue ? 0.8 : 1)
                        .offset(x: isTapped.wrappedValue ? -3 : 5, y: isTapped.wrappedValue ? -12 : 0)
                        .foregroundColor(.gray)
                        .padding(10)
                    
                    ,alignment: .leading
                )
        }
    }
}

struct SecondAddressView_Previews: PreviewProvider {
    static var previews: some View {
        SecondAddressView()
    }
}
