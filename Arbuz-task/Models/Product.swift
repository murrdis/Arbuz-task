//
//  Product.swift
//  Arbuz-task
//
//  Created by Диас Мурзагалиев on 18.05.2023.
//

import Foundation

struct Product: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var price: Int
    var jump: Int
    var availableQuantity: Int
    var description: String
    var fullDescription: String
    var unitofMeasurement: String
    
    // comparing two product to be same
    func sameProduct(product: Product) -> Bool {
        if(self.name == product.name){
            return true
            // in our case only name check will be enought
        }
        return false
    }
}
