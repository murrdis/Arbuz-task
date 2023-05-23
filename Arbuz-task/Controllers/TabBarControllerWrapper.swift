//
//  TabBarControllerWrapper.swift
//  Arbuz-task
//
//  Created by Диас Мурзагалиев on 23.05.2023.
//

import Foundation
import SwiftUI

struct TabBarControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> TabBarController {
        return TabBarController()
    }
    
    func updateUIViewController(_ uiViewController: TabBarController, context: Context) {
        // Update the view controller if needed
    }
}
