//
//  ContentView.swift
//  Grocery
//
//  Created by Apple on 12/08/24.
//

import SwiftUI

struct DashboardView: View {
    
    @StateObject var dashboardViewModel: DashboardViewModel = DashboardViewModel()
   
    var body: some View {
        
        
        NavigationStack {
            ScrollView {
                    
                    VStack {
                        
                        NavBarView()
                        
                        CategoryView(viewModel: dashboardViewModel)
                        
                        productHorzontalListView
                            
                    }
                    
                    ProductsListView(viewModel: dashboardViewModel)
                    
                }
            .background(Color(red: 225 / 255, green: 224 / 255, blue: 238 / 255))
        }
        
    }
    
    var productHorzontalListView: some View {
        ScrollView(.horizontal, showsIndicators: false)  {
            
            HStack(spacing: 16) {
                
                ForEach(dashboardViewModel.selectedCategoryItems) { item in
                    
                    NavigationLink {
                        ProductDetailsView(product: item)
                    } label: {
                        DashboardProductView(product: item)
                            .scrollTransition(
                                topLeading: .interactive,
                                bottomTrailing: .interactive,
                                axis: .horizontal) { effect, phase in
                                    effect
                                        .scaleEffect(phase == .identity ? 1 : 0.3)
                                        .offset(y: phase == .identity ? 0 : 50)
                                        .rotationEffect(phase == .identity ? Angle(degrees: 0) : Angle(degrees: 45))
                                        
                                }
                    }
                    .foregroundColor(.black)
                }
            }
            .padding()
            
        }
    }
}



#Preview {
    DashboardView()
}
