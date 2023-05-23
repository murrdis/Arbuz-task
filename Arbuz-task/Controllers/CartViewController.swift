//
//  CartViewController.swift
//  Arbuz-task
//
//  Created by Диас Мурзагалиев on 20.05.2023.
//

import UIKit
import SwiftUI

class CartViewController: UIViewController {
    
    var collectionView: UICollectionView?
    @ObservedObject var cartViewModel = CartViewModel.cartObj
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        
        collectionView?.dataSource = self
        
        view.addSubview(collectionView ?? UIView())
        navigationController?.navigationBar.isHidden = false


        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView?.reloadData()
        navigationController?.navigationBar.isHidden = false
        
        if (cartViewModel.totalSum != 0) {
            let bottomView = UIHostingController(rootView: OrderingButton())
            addChild(bottomView)
            bottomView.view.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(bottomView.view)
            
            NSLayoutConstraint.activate([
                bottomView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                bottomView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                bottomView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                bottomView.view.heightAnchor.constraint(equalToConstant: 120)
            ])
            
            bottomView.didMove(toParent: self)
        }
    }
    
    private func setupCollectionView() {
        let layoutCollection = UICollectionViewFlowLayout()
        layoutCollection.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layoutCollection.itemSize = CGSize(width: self.view.frame.width, height: 100)
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layoutCollection)
        collectionView?.register(CartViewCollectionCell.self, forCellWithReuseIdentifier: "MyCell")
        collectionView?.backgroundColor = UIColor.white
    }

}

extension CartViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cartViewModel.selectedProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! CartViewCollectionCell
        myCell.setupView(product: cartViewModel.selectedProductsKeysArray[indexPath.row], amount: cartViewModel.selectedProducts[cartViewModel.selectedProductsKeysArray[indexPath.row]] ?? 0)
        return myCell
    }

}


struct OrderingButton: View {
    
    var cartViewModel = CartViewModel.cartObj
    var body: some View {
        NavigationLink (
            destination: FinalStageofOrderingView(),

            label: {
                HStack {
                    Spacer()
                    VStack {
                        Text("Перейти к оплате")
                            .foregroundColor(.white)
                            .font(.custom("Arial", size: 17))
                            .fontWeight(.semibold)
                        Text("\(cartViewModel.totalSum) ₸")
                            .font(.custom("Arial", size: 14))
                            .foregroundColor(.white)
                    }
                    .padding(.vertical, 5)
                    Spacer()
                }
            }
        )
        
        .background(.green.opacity(0.75))
        .cornerRadius(20)
        .buttonStyle(.bordered)
        .padding(.horizontal, 20)
    }
}
