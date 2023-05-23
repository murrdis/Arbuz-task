//
//  CustomHeaderView.swift
//  Arbuz-task
//
//  Created by Диас Мурзагалиев on 23.05.2023.
//

import SwiftUI

struct CustomHeaderView: View {
    var text: String
    var body: some View {
        
        Text(text)
            .font(.custom("Arial", size: 22))
            .fontWeight(.semibold).foregroundColor(.black)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 8)
        
    }
}

//struct CustomHeaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomHeaderView()
//    }
//}
