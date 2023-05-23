//
//  TabBarController.swift
//  Arbuz-task
//
//  Created by Диас Мурзагалиев on 18.05.2023.
//

import UIKit

class TabBarController: UITabBarController{
    // singleton due to the fact the we have only one cart in whole app
    
     override func viewDidLoad() {
         super.viewDidLoad()
         
         addLogoToTheNavigationBar()
                  
         object_setClass(self.tabBar, CustomTabbar.self)
         (self.tabBar as! CustomTabbar).setup()
         
         generateTabBar()
     }
    
    private func generateTabBar() {
        viewControllers = [
        generateVC(viewController: ViewController(), image: UIImage(systemName: "house")),
        generateVC(viewController: SearchViewController(), image: UIImage(systemName: "text.magnifyingglass")),
        generateVC(viewController: CartViewController(), image: UIImage(systemName: "cart")),
        generateVC(viewController: HeartViewController(), image: UIImage(systemName: "suit.heart")),
        generateVC(viewController: PineappleViewController(), image: UIImage(systemName: "seal"))
        ]
       
    }
    
    private func generateVC(viewController: UIViewController, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.image = image
        return viewController
    }
    
    private func addLogoToTheNavigationBar() {
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 25))
        let imageView = UIImageView(image: UIImage(named: "arbuzlogo"))
        imageView.frame = customView.bounds
        customView.addSubview(imageView)

        // Create a UIBarButtonItem with the custom view logo
        let customBarButton = UIBarButtonItem(customView: customView)
        
        // Set the custom button as the leftBarButtonItem of the navigationItem
        navigationItem.leftBarButtonItem = customBarButton
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false

    }
}

class CustomTabbar: UITabBar{
    func setup() {
        backgroundColor = .white
        selectedItem?.badgeColor = .green
        unselectedItemTintColor = .black
        barTintColor = .white
        isTranslucent = false
    }
}
