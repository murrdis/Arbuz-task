//
//  showingModel.swift
//  Arbuz-task
//
//  Created by Диас Мурзагалиев on 23.05.2023.
//

import SwiftUI

struct showingModel: View {
    
    var title: String
    var choice1: String
    var choice2: String
    @Binding var isShowing: Bool
    @Binding var method: String
    
    var body: some View {
        let choice = Binding<String> (
            get: { $method.wrappedValue },
            set: { newValue in $method.wrappedValue = newValue }
            )
        
        VStack(spacing: 20) {
            Spacer()
            Text(title)
                .font(.custom("Arial", size: 22))
                .fontWeight(.semibold).foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.vertical, 8)
            Button() {
                choice.wrappedValue = choice1
            } label: {
                HStack {
                    if title == "Методы оплаты" {
                        Image(systemName: "creditcard").foregroundColor(.black)
                    }
                    VStack(alignment: .leading) {
                        Text(" \(choice1)")
                            .foregroundColor(.black)
                            .font(.custom("Arial", size: 15))
                        if title == "Если товара не будет в наличии" {
                            Text(" Замену подберет магазин. Если не получится, \n мы уведомим вас по SMS")
                                .font(.custom("Arial", size: 10))
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.leading)
                                .padding(.horizontal, 2)
                            
                        }
                    }
                    Spacer()
                    if choice.wrappedValue == choice1 {
                        Image(systemName: "checkmark.circle.fill").foregroundColor(
                            .green).imageScale(.large)
                        
                    } else {
                        Image(systemName: "circle.fill").foregroundColor(Color(red: 0.97, green: 0.97, blue: 0.97))
                            .imageScale(.large)
                    }
                }
            }
            
            Divider()
            
            Button() {
                choice.wrappedValue = choice2
            } label: {
                HStack {
                    if title == "Методы оплаты" {
                        Image(systemName: "creditcard.viewfinder").foregroundColor(.black)
                    }
                    VStack(alignment: .leading) {
                        Text(" \(choice2)")
                            .foregroundColor(.black)
                            .font(.custom("Arial", size: 15))
                        if title == "Если товара не будет в наличии" {
                            Text(" Если товар будет отсутствовать, вы \n получите SMS")
                                .font(.custom("Arial", size: 10))
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.leading)
                                .padding(.horizontal, 2)
                            
                        }
                    }
                    Spacer()
                    if choice.wrappedValue == choice2 {
                        Image(systemName: "checkmark.circle.fill").foregroundColor(.green)
                            .imageScale(.large)
                    } else {
                        Image(systemName: "circle.fill").foregroundColor(Color(red: 0.97, green: 0.97, blue: 0.97))
                            .imageScale(.large)
                    }
                }
            }
            Spacer()
            Button() {
                $method.wrappedValue = choice.wrappedValue
                $isShowing.wrappedValue = false
            } label: {
                Spacer()
                Text("Подтвердить")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .padding(.vertical, 10)
                Spacer()
            }
            .background(.green)
            .cornerRadius(15)
            .buttonStyle(.bordered)
            
        }
        .padding(.horizontal, 23)
    }
}

//struct showingModel_Previews: PreviewProvider {
//    static var previews: some View {
//        showingModel()
//    }
//}
