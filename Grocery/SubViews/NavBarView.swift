//
//  NavBarView.swift
//  Grocery
//
//  Created by Apple on 13/08/24.
//

import SwiftUI

struct NavBarView: View {
    
    @ObservedObject var cart = Cart.shared
    
    var body: some View {
        HStack{
            Image("kalki")
                .resizable()
                .frame(width: 50, height: 50)
                .scaledToFill()
                
                
                .cornerRadius(10)
            
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .foregroundColor(.black)
                    .frame(width: 30, height: 30)
                    .padding()
                    .cornerRadius(10)
            }
            
            NavigationLink {
                CartView()
            } label: {
                Image(systemName: "cart")
                    .resizable()
                    .foregroundColor(.black)
                    .frame(width: 30, height: 30)
                    .padding()
                    .cornerRadius(10)
                    .overlay(alignment: .topTrailing) {
                        Text(String(cart.cartCount))
                            .padding(8)
                            .background(Color.red)
                            .foregroundStyle(Color.white)
                            .font(.callout)
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    }
            }
            

        }
        .padding()
    }
}

#Preview {
    NavBarView()
}
