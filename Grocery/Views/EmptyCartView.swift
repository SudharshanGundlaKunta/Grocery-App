//
//  EmptyCartView.swift
//  Grocery
//
//  Created by Apple on 01/09/24.
//

import SwiftUI

struct EmptyCartView: View {
    var body: some View {
        VStack(spacing: 24) {
            
            Image("nilCart")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .cornerRadius(50)
                .padding()
            
            Text("Cart is Empty Pleasse Add Items😥🛒 ")
                .font(.title3)
                .fontWeight(.medium)
        }
        .padding()
    }
}
