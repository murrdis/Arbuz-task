//
//  DetailedProductView.swift
//  Arbuz-task
//
//  Created by Диас Мурзагалиев on 19.05.2023.
//

import SwiftUI

struct DetailedProductView: View {
    // MARK: - Properties
    @Environment(\.presentationMode) var presentation
    @State var product: Product
    @Binding var amountofChosenProduct: Int
    
    // MARK: - CartSingleton
    var cartViewModel = CartViewModel.cartObj
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    MainViewofProduct()
                        .ignoresSafeArea(.all)
                }
                BottomButton()
            }
            .navigationBarHidden(false)
            .navigationBarTitle("", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        self.presentation.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                    } label: {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.secondary)
                    }
                }
            }

        }
        
    }
    
    // MARK: - MainViewofProduct
    @ViewBuilder func MainViewofProduct() -> some View{
        VStack(spacing: 5){
            Image(product.name)
                .resizable()
                .scaledToFit()
            Text(product.description)
                .font(.body)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
                .padding( .top, 5)
                .padding(.horizontal, 15)
            Text("шт")
                .foregroundColor(.secondary)
                .fontWeight(.medium)
            Divider()
            HStack(){
                Text("Описание")
                    .padding(.leading, 12)
                Spacer()
            }
            Text(product.fullDescription)
                .padding(.horizontal, 12)
                .font(.callout)
                .multilineTextAlignment(.leading)
                .foregroundColor(.gray)
            
        }
    }
    
    // MARK: - BottomButton
    @ViewBuilder func BottomButton() -> some View{
        HStack(spacing: 10){
            if  amountofChosenProduct != 0 {
                Button {
                    withAnimation(.easeOut(duration: 0.5)) {
                        if(amountofChosenProduct != 0) {
                            amountofChosenProduct-=1
                        }
                    }
                    cartViewModel.syncronizeProductWithCart(product: product, amount: amountofChosenProduct)
                } label: {
                    Image(systemName: "minus")
                        .foregroundColor(.white)
                        .font(.title2)
                }
                Spacer()
            }else{
                Spacer()
            }
            Text("\(product.price)₸")
                .foregroundColor(.white)
                .font(.title3)
            if amountofChosenProduct != 0 {
                Text("x \(amountofChosenProduct)")
                    .foregroundColor(.white)
                    .font(.title3)
                Spacer()
            }
            Button {
                withAnimation(.easeOut(duration: 0.5)) {
                    amountofChosenProduct+=1
                }
                cartViewModel.syncronizeProductWithCart(product: product, amount: amountofChosenProduct)
            } label: {
                Image(systemName: "plus")
                    .foregroundColor(.white)
                    .font(.title2)
            }
            if amountofChosenProduct == 0{
                Spacer()
            }
        }
        .frame(width: .infinity, height: 70)
        .padding(.horizontal)
        .background((amountofChosenProduct==0) ? .gray : .green)
        .onTapGesture {
            if amountofChosenProduct == 0{
                withAnimation(.easeOut(duration: 0.5)) {
                    amountofChosenProduct = 1
                }
                cartViewModel.syncronizeProductWithCart(product: product, amount: amountofChosenProduct)
            }
        }
    }
    
    
    // MARK: - ArbuzBuyingView
}




//// MARK: - Preview
//struct DetailedProductView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailedProductView(product: DataBase.watermellon,amountofChosenProduct: .)
//    }
//}
