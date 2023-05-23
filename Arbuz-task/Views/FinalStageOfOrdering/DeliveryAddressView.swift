//
//  DeliveryView.swift
//  Arbuz-task
//
//  Created by Диас Мурзагалиев on 23.05.2023.
//

import SwiftUI

struct DeliveryAddressView: View {
    
    @Binding var showAdressModel: Bool
    @Binding var address: String
    
    var body: some View {
        Group {
            CustomHeaderView(text: "Адрес доставки")
            
            Button() {
                showAdressModel = true
                
            } label: {
                HStack {
                    Image(systemName: "car").foregroundColor(.black)
                    if address == "" {
                        Text(" Добавить новый адрес")
                            .foregroundColor(.black)
                            .font(.custom("Arial", size: 15))
                    } else {
                        Text(" \(address)")
                            .foregroundColor(.black)
                            .font(.custom("Arial", size: 15))
                    }
                    Spacer()
                    Text(">")
                        .foregroundColor(.gray)
                }
            }
            
            Divider()
            
        }
    }
}

//struct DeliveryAddressView_Previews: PreviewProvider {
//    static var previews: some View {
//        DeliveryAddressView()
//    }
//}
