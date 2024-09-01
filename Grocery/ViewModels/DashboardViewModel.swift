//
//  DashboardViewModel.swift
//  Grocery
//
//  Created by Apple on 12/08/24.
//

import Foundation

class DashboardViewModel: ObservableObject {
    
    @Published var groceries: ProductsDetails?
    @Published var categories: [String] = ["beauty", "fragrances", "furniture", "groceries"]
    @Published var selectedCategory = "beauty"
    @Published var selectedCategoryItems: [Product] = []
    @Published var topProducts: [Product] = []
    
    init() {
        getData()
        
    }
    
    func getData() {
        groceries = loadJSON("ProductsDetails.json")
        selectedCategory = categories.first ?? ""
        getSelectedCategoryData()
        
    }
    
    func getSelectedCategoryData() {
        selectedCategoryItems = groceries?.product.filter {$0.category.rawValue == selectedCategory} ?? []
        topProducts = groceries?.product.filter {$0.rating > 4.5} ?? []
    }
    
}
