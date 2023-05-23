//
//  ViewController.swift
//  Arbuz-task
//
//  Created by Диас Мурзагалиев on 18.05.2023.
//

import UIKit
import SwiftUI

class ViewController: UIViewController{
    
    var collectionView: UICollectionView?
    var cartViewModel = CartViewModel.cartObj
    @ObservedObject var db = DataBase.db
    
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
    }
    
    private func setupCollectionView(){
        let layoutCollection = UICollectionViewFlowLayout()
        layoutCollection.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layoutCollection.itemSize = CGSize(width: (self.view.frame.width/3)-15, height: 190)
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layoutCollection)
        collectionView?.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        collectionView?.backgroundColor = UIColor.white
    }

    func presentPhoneAuthView() {
        let phoneAuthView = PhoneAuthView() // Replace "PhoneAuthView" with the actual name of your SwiftUI view
        
        let hostingController = UIHostingController(rootView: phoneAuthView)
        
        let navigationController = UINavigationController(rootViewController: hostingController)
        navigationController.modalPresentationStyle = .fullScreen // Adjust presentation style if needed
        
        present(navigationController, animated: true, completion: nil)
    }
    
}

extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return db.goods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! CustomCollectionViewCell
        
        myCell.setupView(product: Array(db.goods.keys)[indexPath.row], amount: cartViewModel.selectedProducts[Array(db.goods.keys)[indexPath.row]] ?? 0)
        
        myCell.backgroundColor = UIColor.blue
        return myCell
    }

}

