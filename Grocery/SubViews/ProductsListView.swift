//
//  ProductsListView.swift
//  Grocery
//
//  Created by Apple on 13/08/24.
//

import SwiftUI

struct ProductsListView: View {
    
    @ObservedObject var viewModel: DashboardViewModel
    
    var body: some View {
        
        VStack {
            Text("Popular")
                .font(.title3)
                .fontWeight(.semibold)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                .padding(.horizontal)
                .fontDesign(.rounded)
            
            listRowView
        
        }
        .padding(.horizontal)
        
    }
    
    var listRowView: some View {
        ForEach(viewModel.topProducts) { item in
            
            
            NavigationLink {
                
                ProductDetailsView(product: item)
                
            } label: {
                
                HStack {
                    AsyncImage(url: URL(string: item.images.first ?? "")) { image in
                        
                        image
                            .resizable()
                            .imageScale(.large)
                            .frame(width: 50, height: 50)
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(8)
                            
                        
                    } placeholder: {
                        
                        Image(systemName: "photo.artframe")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.gray.opacity(0.5))
                            .overlay(alignment: .center) {
                                ProgressView()
                                    .colorMultiply(.blue)
                                    .font(.largeTitle)
                            }
                        
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        Text(item.title)
                            .font(.system(size: 12).weight(.semibold))
                            .fontDesign(.rounded)
                            
                        Text(item.category.rawValue)
                            .font(.system(size: 10).weight(.regular))
                            .foregroundStyle(Color.gray)
                            .fontDesign(.rounded)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                    
                    Text(item.price.convertToDollers())
                        .font(.system(size: 12).weight(.semibold))
                        .padding(.horizontal, 4)
                        .fontDesign(.rounded)
                    
                    Spacer()
                }
                .foregroundColor(.black)
                .padding(.leading, 4)
            }

        }
    }
}

//#Preview {
//    ProductsListView()
//}
