//
//  ItemInCartView.swift
//  Arbuz-task
//
//  Created by Диас Мурзагалиев on 19.05.2023.
//

import SwiftUI

struct ItemInCartView: View {
    // MARK: - Properties
    @ObservedObject var db = DataBase.db
    @State var product: Product
    @State var amountofChosenProduct: Int
    @State var showPopOverWindow: Bool = false
    // MARK: - CartSingleton
    var cartViewModel = CartViewModel.cartObj
    
    // MARK: - Body
    var body: some View {
        HStack {
            Button() {
                showPopOverWindow = true
            } label: {
                Image(product.name)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(20)
                    .padding(0)
            }
            VStack(alignment: .leading, spacing: 15) {
                Button() {
                    showPopOverWindow = true
                } label: {
                    VStack(alignment: .leading, spacing: 2){
                        Text(product.description)
                            .font(.footnote)
                            .multilineTextAlignment(.leading)
                            .frame(height: 15)
                            .foregroundColor(.black)
                            .padding(.horizontal,5)
                        Text(product.unitofMeasurement)
                            .font(.footnote)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.gray)
                            .padding(.leading, 5)
                    }
                }.popover(isPresented: $showPopOverWindow ,
                          arrowEdge: Edge.trailing) {
                    DetailedProductView(product:product,amountofChosenProduct: $amountofChosenProduct)
                }
                buyButton()
                    .frame(width: 140, height: 45)
                    .cornerRadius(200)
            }
            Spacer()
            VStack {
                Spacer()
                Text("\(amountofChosenProduct*product.price) ₸")
                    .foregroundColor(.black)
                    .font(.body)
                    .bold()
                    .padding(.vertical, 20)
            }
            
        }
        .frame(height: 100)
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 13)
    }
    
    @ViewBuilder func buyButton() -> some View {
        HStack(){
            Button {
                withAnimation(.easeOut(duration: 0.3)) {
                    if(amountofChosenProduct != 0) {
                        amountofChosenProduct -= product.jump
                    } else {
                        
                        //MAKE IT DISSAPEAR
                    }
                }
                cartViewModel.syncronizeProductWithCart(product: product, amount: amountofChosenProduct)
            } label: {
                Image(systemName: "minus")
                    .foregroundColor(.black)
                    .padding(.leading, 15)
                    .bold(true)
            }
            .padding(.horizontal, 5)
            
            VStack(spacing: -3) {
                Text("\(amountofChosenProduct)")
                    .foregroundColor(.black)
                    .font(.body)
                    .bold()
                if (product.unitofMeasurement  == "кг") {
                    Text(product.unitofMeasurement)
                        .foregroundColor(.black)
                        .font(.footnote)
                        .italic()
                        .minimumScaleFactor(0.6)
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            
            if amountofChosenProduct >= db.goods[product] ?? 0 {
                Button {
                    withAnimation(.easeOut(duration: 0.3)) {
                    }
                    
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(.gray)
                        .padding(.trailing, 15)
                        .bold(true)
                }
                .padding(.horizontal, 5)
            } else {
                Button {
                    
                    withAnimation(.easeOut(duration: 0.3)) {
                        amountofChosenProduct += product.jump
                    }
                    cartViewModel.syncronizeProductWithCart(product: product, amount: amountofChosenProduct)
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(.black)
                        .padding(.trailing, 15)
                        .bold(true)
                }
                .padding(.horizontal, 5)
            }
        }
        .frame(width: 150, height: 40)
        
        .background(Color(red: 0.95, green: 0.95, blue: 0.95))
    }
}

struct ItemInCartView_Previews: PreviewProvider {
    static var previews: some View {
        ItemInCartView(product: DataBase.watermellon, amountofChosenProduct: 2)
    }
}
