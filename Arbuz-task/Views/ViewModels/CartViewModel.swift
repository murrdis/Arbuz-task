//
//  CartViewModel.swift
//  Arbuz-task
//
//  Created by Диас Мурзагалиев on 20.05.2023.
//

import Foundation

// Singleton will be in place due to the fact the we have only one cart in whole app
class CartViewModel: ObservableObject{
    // selectedProduct - is the list of products in cart
    @Published var selectedProducts: [Product: Int] = [:]
    @Published var keysArray: [Product] = []
    @Published var totalSum: Int = 0
    @Published var bonuses: Int = 0
    @Published var addresses: [String] = []
    @Published var currentAddress: String = ""
    // create a singleton
    static let cartObj = CartViewModel()

     // create a private initializer
    private init() {
      
    }
    
    // to make same amount of product or erase product from chart(case amount == 0)
    func syncronizeProductWithCart(product : Product, amount: Int) {
        if (amount == 0) {
            selectedProducts[product] = nil
            
        }
        else{
            selectedProducts[product] = amount
        }
        keysArray = Array(selectedProducts.keys)
        totalSum = selectedProducts.reduce(0) { (result, item) in
            let (product, quantity) = item
            return result + (product.price * quantity)
        }
    }
}
