//
//  DashboardProductView.swift
//  Grocery
//
//  Created by Apple on 13/08/24.
//

import SwiftUI

struct DashboardProductView: View {
    
    var product: Product
    @ObservedObject var cart = Cart.shared
    
    var body: some View {
        
        VStack {
            AsyncImage(url: URL(string: product.images.first ?? "")) { image in
                image
                    .resizable()
                    .imageScale(.large)
                
            } placeholder: {
                Image(systemName: "photo.artframe")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.gray.opacity(0.5))
                    .padding()
                    .overlay(alignment: .center) {
                        ProgressView()
                            .colorMultiply(.blue)
                            .font(.largeTitle)
                    }
            }
            
            VStack(alignment: .leading) {
                Text(product.title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                    .fontDesign(.rounded)
                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                
                
                Text(product.category.rawValue)
                    .font(.subheadline)
                    .fontWeight(.regular)
                    .foregroundColor(.gray)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                    .fontDesign(.rounded)
                
                HStack {
                    Text(String(product.price.convertToDollers()))
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                        .padding(.top, 2)
                        .fontDesign(.rounded)
                    
                    Spacer()
                    
                    if cart.items.contains(where: {$0.id == product.id}){
                        HStack(spacing: 8) {
                            Button {
                                cart.removeItem(product)
                            }label: {
                                Text("-")
                                    .frame(width: 20, height: 20, alignment: .center)
                                    .background(Color.gray.opacity(0.3))
                                    .font(.subheadline)
                                    .foregroundStyle(Color.white)
                                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            }
                            
                            Text(String(cart.getItemQuantity(product.id)))
                                .font(.subheadline)
                            
                            Button {
                                cart.addItem(product)
                            }label: {
                                Text("+")
                                    .frame(width: 20, height: 20, alignment: .center)
                                    .background(Color.orange)
                                    .font(.subheadline)
                                    .foregroundStyle(Color.white)
                                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            }
                        }
                    }else {
                        
                        Button {
                            Cart.shared.addItem(product)
                        }label: {
                            Text("Add")
                                .padding(.horizontal)
                                .padding(.vertical, 4)
                                .foregroundStyle(Color.red)
                                .font(.headline)
                                .overlay {
                                    RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                        .stroke(lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                                        .fill(Color.red)
                                    
                                }
                        }
                    }
                   
                    
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                
                
                
            }
            
        }
        
        .padding()
        .frame(width: 180, height: 300)
        .background(.regularMaterial)
        .cornerRadius(24)
        .shadow(radius: 6, y: 6)
        
    }
}

#Preview {
    DashboardView()
}
