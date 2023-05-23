//
//  AddressModelView.swift
//  Arbuz-task
//
//  Created by Диас Мурзагалиев on 23.05.2023.
//

import SwiftUI

struct AddressModelView: View {
    
    @State var isFirstAddressViewNeeded = false
    @Binding var selectedDay: String
    @Binding var selectedFollowPeriod: String
    @Binding var selectedTime: String

    @State var address = CartViewModel.cartObj.currentAddress
    
    var body: some View {
        VStack {
            Text("Доставка")
                .foregroundColor(.black)
                .fontWeight(.semibold)
                .padding(.vertical, 5)
            Text("\(selectedFollowPeriod) \(selectedDay) \(selectedTime)")
                .foregroundColor(.black)
                .padding(.vertical, 5)
            if address != "" {
                HStack {
                    VStack(alignment: .leading) {
                        Text(address)
                            .foregroundColor(.black)
                            .font(.custom("Arial", size: 15))
                    }
                    Spacer()
                    Image(systemName: "checkmark.circle.fill").imageScale(.large).foregroundColor(.green)
                }.padding(.horizontal, 15)
            }
            Divider().padding(.horizontal, 15)
            Button {
                isFirstAddressViewNeeded = true
            } label: {
                HStack {
                    Image(systemName: "plus").foregroundColor(.black).fontWeight(.semibold)
                    VStack(alignment: .leading) {
                        Text("Добавить новый адрес")
                            .foregroundColor(.black)
                            .font(.custom("Arial", size: 15))
                        Text("Весь список адресов")
                            .font(.custom("Arial", size: 10))
                            .foregroundColor(.gray)
                            .frame(alignment: .leading)
                            .padding(.horizontal, 2)
                    }
                    Spacer()
                }
            }
            .fullScreenCover(isPresented: $isFirstAddressViewNeeded, content: {
                NavigationView {
                    FirstAddressView(isPresented: $isFirstAddressViewNeeded, currentAddress: $address)
                        .navigationBarTitle("Мои адреса", displayMode: .inline)
                        .navigationBarItems(leading: Button(action: {
                            isFirstAddressViewNeeded = false
                        }) {
                            Image(systemName: "xmark")
                                .imageScale(.medium)
                                .foregroundColor(.black)
                                .fontWeight(.semibold)
                        })
                }
            })
            .padding(15)
        }
    }
}

//
//struct AddressModelView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddressModelView()
//    }
//}
