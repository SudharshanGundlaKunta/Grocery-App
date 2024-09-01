//
//  CategoryView.swift
//  Grocery
//
//  Created by Apple on 13/08/24.
//

import SwiftUI

struct CategoryView: View {
    
    @ObservedObject var viewModel: DashboardViewModel
    @Namespace var bottomLine
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 24) {
                ForEach(viewModel.categories, id: \.self) { category in
                    
                    
                    ZStack(alignment: .bottom) {
                        if category == viewModel.selectedCategory{
                            RoundedRectangle(cornerRadius: 10)
                                .matchedGeometryEffect(id: "bottomLine", in: bottomLine)
                                .frame(width: 60, height: 3)
                                .offset(y: 1)
                        }
                        
                        Text(category)
                            .font(viewModel.selectedCategory == category ? .title3 : .callout)
                            .fontWeight(viewModel.selectedCategory == category ? .semibold : .regular)
                            .foregroundColor(viewModel.selectedCategory == category ? .black : .gray)
                            .frame(height: 50)
                            .onTapGesture {
                                withAnimation {
                                    viewModel.selectedCategory = category
                                    viewModel.getSelectedCategoryData()
                                }
                                
                        }
                    }
                }
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            .padding()
        }
        .onAppear {
            viewModel.selectedCategory = viewModel.categories.first ?? ""
        }
    }
}

//#Preview {
//    CategoryView()
//}
