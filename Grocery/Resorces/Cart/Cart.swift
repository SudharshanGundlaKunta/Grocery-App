//
//  Cart.swift
//  Grocery
//
//  Created by Apple on 25/08/24.
//

import Foundation

class Cart: ObservableObject {
    
    static var shared = Cart()
    private init() {}
    
    @Published var items: [Product] = []
    
    func addItem( _ item: Product) {
        if let index = items.firstIndex(where: {$0.id == item.id}) {
            items[index].quantity! += 1
        }else {
            var newItem = item
            newItem.quantity = 1
            items.append(newItem)
        }
    }
    
    func removeItem(_ item: Product) {
        if let index = items.firstIndex(where: {$0.id == item.id}) {
            if items[index].quantity ?? 0 <= 1 {
                deleteItem(item)
            }else {
                items[index].quantity! -= 1
            }
        }
    }
    
    func deleteItem(_ item: Product){
        if let index = items.firstIndex(where: {$0.id == item.id}) {
            items.remove(at: index)
        }
    }
    
    func clearCart() {
        items.removeAll()
    }
    
    func totalPrice() -> Double{
        
        var totlaValue = items.reduce(0) { $0 + ($1.price * Double($1.quantity ?? 0)) }
        totlaValue = (totlaValue * 1000).rounded() / 1000
        return totlaValue
    }
    
    var cartCount: Int{
        return items.count
    }
    
    func getItemQuantity(_ id: Int) -> Int {
        if let index = items.firstIndex(where: {$0.id == id}) {
            return items[index].quantity ?? 0
        }
        return 0
    }
}
