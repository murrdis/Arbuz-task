//
//  ViewController.swift
//  Arbuz-task
//
//  Created by Диас Мурзагалиев on 18.05.2023.
//

import UIKit

class ViewController: UIViewController{
    
    var collectionView: UICollectionView?
    var cartViewModel = CartViewModel.cartObj
    
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


}

extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constants.goods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! CustomCollectionViewCell
        
        myCell.setupView(product: Constants.goods[indexPath.row], amount: cartViewModel.selectedProducts[Constants.goods[indexPath.row]] ?? 0)
        
        myCell.backgroundColor = UIColor.blue
        return myCell
    }

}

