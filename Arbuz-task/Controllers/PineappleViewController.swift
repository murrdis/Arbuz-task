//
//  PineappleViewController.swift
//  Arbuz-task
//
//  Created by Диас Мурзагалиев on 18.05.2023.
//

import UIKit
import SwiftUI

class PineappleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let swiftUIContainer = UIHostingController(rootView: PhoneAuthView())
                addChild(swiftUIContainer)
                view.addSubview(swiftUIContainer.view)
                
                swiftUIContainer.view.frame = view.bounds
                
                swiftUIContainer.didMove(toParent: self)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
