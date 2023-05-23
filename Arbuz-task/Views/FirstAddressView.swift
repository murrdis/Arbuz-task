//
//  FirstAddressView.swift
//  Arbuz-task
//
//  Created by Диас Мурзагалиев on 22.05.2023.
//

import SwiftUI

struct FirstAddressView: View {
    @Environment(\.presentationMode) private var presentationMode
    @Binding var isPresented: Bool
    @Binding var currentAddress: String
    var cartViewModel = CartViewModel.cartObj
    
    var body: some View {
        
        VStack(spacing: 15) {
            ForEach(0..<cartViewModel.addresses.count) { index in
                Button(action: {
                    cartViewModel.currentAddress = cartViewModel.addresses[index]
                    presentationMode.wrappedValue.dismiss()
                    currentAddress = cartViewModel.addresses[index]
                    isPresented = false
                }, label: {
                    HStack {
                        Text(cartViewModel.addresses[index])
                            .foregroundColor(.black)
                            .font(.custom("Arial", size: 15))
                        Spacer()
                        Text(">")
                            .foregroundColor(.gray)
                    }
                })
                Divider()
            }
            Spacer()
            NavigationLink {
                SecondAddressView()
            } label: {
                Spacer()
                Text("Добавить новый адрес")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .padding(.vertical, 10)
                Spacer()
            }
            .background(.green)
            .cornerRadius(15)
            .buttonStyle(.bordered)
        }
        .padding(20)
        .onAppear(){
            
        }
    }
    
    
}

//struct FirstAddressView_Previews: PreviewProvider {
//    static var previews: some View {
//        FirstAddressView(isPresented: Binding<Bool>)
//    }
//}
