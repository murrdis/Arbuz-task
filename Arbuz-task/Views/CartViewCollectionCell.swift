//
//  CartViewCollectionCell.swift
//  Arbuz-task
//
//  Created by Диас Мурзагалиев on 20.05.2023.
//

import UIKit
import SwiftUI

class CartViewCollectionCell: UICollectionViewCell {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(product: Product, amount: Int) {
        let pr2 = ItemInCartView(product: product, amountofChosenProduct: amount)
        let childView2 = UIHostingController(rootView: pr2)
        childView2.view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(childView2.view)
        childView2.view.frame = contentView.frame
    }
}
