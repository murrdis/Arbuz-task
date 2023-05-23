//
//  ItemInCart.swift
//  Arbuz-task
//
//  Created by Диас Мурзагалиев on 18.05.2023.
//

import Foundation

struct ItemInCart: Identifiable{
    let id = UUID()
    var product: Product
    var amount: Int
    
    func getOverallPrice() ->Int{
        return product.price*amount
    }
    
    mutating func incrementAmountByOne(){
        amount+=1
    }
    
    mutating func decrementAmountByOne(){
        amount-=1
    }
}
