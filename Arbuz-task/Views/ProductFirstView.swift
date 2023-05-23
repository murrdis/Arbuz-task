//
//  ProductFirstView.swift
//  Arbuz-task
//
//  Created by Диас Мурзагалиев on 19.05.2023.
//

import SwiftUI

struct ProductFirstView: View {
    
    // MARK: - Properties
    @State var product: Product
    @State var showPopOverWindow: Bool = false
    @State var amountofChosenProduct: Int
    
    // MARK: - CartSingleton
    var cartViewModel = CartViewModel.cartObj
    

    // MARK: - Body
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            Button() {
                showPopOverWindow = true
            } label: {
                VStack(alignment: .leading, spacing: 2){
                    Image(product.name)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(20)
                        .padding(0)
                    Text(product.description)
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                        .frame(height: 35)
                        .foregroundColor(.black)
                        .padding(.horizontal,5)
                    Text("шт")
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
                .frame(height: 33)
                .cornerRadius(20)
        }
    }
    
    @ViewBuilder func buyButton() -> some View {
        HStack(spacing: 2){
            if amountofChosenProduct != 0 {
                Button {
                    withAnimation(.easeOut(duration: 0.5)) {
                        if(amountofChosenProduct != 0) {
                            amountofChosenProduct -= product.jump
                        }
                    }
                    cartViewModel.syncronizeProductWithCart(product: product, amount: amountofChosenProduct)
                } label: {
                    Image(systemName: "minus")
                        .foregroundColor(.white)
                        .padding(.leading, 15)
                        .bold(true)
                }
            } else {
                Spacer()
            }
            if amountofChosenProduct != 0 {
                VStack(spacing: -3) {
                    Text("\(amountofChosenProduct)")
                        .foregroundColor(.white)
                        .font(.body)
                        .bold()
                    if (product.unitofMeasurement  == "кг") {
                        Text(product.unitofMeasurement)
                            .foregroundColor(.white)
                            .font(.footnote)
                            .italic()
                            .minimumScaleFactor(0.6)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }else{
                Text("\(product.price)₸")
                    .foregroundColor(.black)
                    .font(.body)
            }
            Button {
                withAnimation(.easeOut(duration: 0.5)) {
                    amountofChosenProduct += product.jump
                }
                cartViewModel.syncronizeProductWithCart(product: product, amount: amountofChosenProduct)
            } label: {
                if amountofChosenProduct == 0{
                    Spacer()
                    Image(systemName: "plus")
                        .foregroundColor(.green)
                        .padding(.trailing, 15)
                        .bold(true)
                } else {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .padding(.trailing, 15)
                        .bold(true)
                }
            }
        }
        .padding(.vertical, 10)
        .ignoresSafeArea()
        .background((amountofChosenProduct==0) ? Color(red: 0.95, green: 0.95, blue: 0.95) : .green)
        .onTapGesture {
            if amountofChosenProduct == 0 {
                withAnimation(.easeOut(duration: 0.5)) {
                    amountofChosenProduct = 1
                    cartViewModel.syncronizeProductWithCart(product: product, amount: amountofChosenProduct)
                }
            }
        }
    }
    
}

// MARK: - Preview
struct ProductFirstView_Previews: PreviewProvider {
    static var previews: some View {
        ProductFirstView(product: Constants.watermellon, amountofChosenProduct: 0)
            .background(.white)
            .frame(width: 150, height: 250)
            .previewLayout(.sizeThatFits)
    }
}
