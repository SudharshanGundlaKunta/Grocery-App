//
//  CartView.swift
//  Grocery
//
//  Created by Apple on 25/08/24.
//

import SwiftUI
import Kingfisher

struct CartView: View {
    
    @ObservedObject var cart = Cart.shared
    @Environment(\.dismiss) var dismiss
    @State var isOrderPlaced = false
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    @ObservedObject var paymentManager = PaymentManager.shared
    
    let bgCOlor = Color(red: 225 / 255, green: 224 / 255, blue: 238 / 255)
    
    var body: some View {
        ZStack {
            Color(red: 225 / 255, green: 224 / 255, blue: 238 / 255)
                .ignoresSafeArea()
            
            ScrollView {
                if cart.cartCount > 0 {
                    cartProductsView
                        .transition(.asymmetric(insertion: .move(edge: .top).animation(.spring), removal:  .opacity.animation(.easeIn)))
                }else {
                    EmptyCartView()
                        .transition(.asymmetric(insertion: .move(edge: .top).animation(.spring), removal:  .opacity.animation(.easeIn)))
                }
            }
            .safeAreaInset(edge: .bottom) {
                chechOutView
            }
            .onChange(of: paymentManager.onResult) { newValue in
                guard let result = newValue else { return }
                if result {
                    alertMessage = "Payment Successful!😍"
                } else {
                    alertMessage = "Payment Failed. Please try again.😥"
                }
                showAlert = true
                paymentManager.onResult = nil
            }
            .fullScreenCover(isPresented: $showAlert) {
                VStack{
                    Text(alertMessage)
                    Button {
                        dismiss()
                    } label: {
                        Text("Go to Home Screen")
                    }

                }
            }
        }
        .navigationTitle("Cart")
        .navigationBarTitleDisplayMode(.large)
    }
    
    var cartProductsView: some View {
        VStack {
            ForEach(cart.items) { item in
                HStack {
                    
                    KFImage(URL(string: item.thumbnail))
                        .resizable()
                        .placeholder {
                            Image(systemName: "photo.artframe")
                                .resizable()
                                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
                                .foregroundColor(.gray.opacity(0.2))
                                .fontWeight(.thin)
                                .scaledToFit()
                                .background(bgCOlor)
                                .overlay(alignment: .center) {
                                    ProgressView()
                                        .colorMultiply(.blue)
                                        .font(.largeTitle)
                                }
                                .cornerRadius(10)
                        }
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                    
                    
                    VStack(alignment: .leading) {
                        Text(item.title)
                            .font(.headline)
                            .fontWeight(.medium)
                            .lineLimit(1)
                        
                        Text(item.price.convertToDollers())
                            
                        
                        HStack(spacing: 16) {
                            Button {
                                cart.removeItem(item)
                            }label: {
                                Text("-")
                                    .frame(width: 30, height: 30, alignment: .center)
                                    .background(Color.gray.opacity(0.3))
                                    .font(.title3)
                                    .foregroundStyle(Color.white)
                                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            }
                            
                            Text(String(item.quantity ?? 0))
                                .font(.headline)
                            
                            Button {
                                cart.addItem(item)
                            }label: {
                                Text("+")
                                    .frame(width: 30, height: 30)
                                    .background(Color.orange)
                                    .font(.title3)
                                    .foregroundStyle(Color.white)
                                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            }
                            
                            Spacer()
                            
                            Button {
                                cart.deleteItem(item)
                            }label: {
                                Image(systemName: "trash.fill")
                                    .font(.title2)
                                    .foregroundStyle(Color.red)
                            }
                        }
                    }
                    .padding(.leading)

                    
                    Spacer()
                    
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .padding()
                .background(Color.white)
                .cornerRadius(25)
                .padding(.horizontal)
            }
            
            
            
        }
    }
    
    var chechOutView: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(.regularMaterial)
            .ignoresSafeArea(edges: [.bottom])
            .frame(height: cart.cartCount > 0 ? 150 : 50)
            .overlay {
                VStack{
                    if cart.cartCount > 0{
                        HStack {
                            Text("Total Amount")
                                .font(.headline)
                                .fontWeight(.medium)
                                .foregroundStyle(Color.gray)
                            Spacer()
                            Text(cart.totalPrice().convertToDollers())
                                .font(.title3)
                                .fontWeight(.medium)
                        }
                        .padding()
                        
                    }
                    Button {
                        if cart.cartCount > 0 {
                            paymentManager.intiatePayment(amount: cart.totalPrice())
                        }else {
                            dismiss()
                        }
                    } label: {
                        Text(cart.cartCount > 0 ? "Check Out" : "Add Items to Cart")
                            .font(.headline)
                            .fontWeight(.medium)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(cart.cartCount > 0 ? Color.black : Color.red)
                            .foregroundStyle(Color.white)
                            .cornerRadius(10)
                        
                        
                    }
                    
                }
                .padding()
            }
        
    }
    
    func getAlertMessage(_ title: String) -> Alert {
        var alert = Alert(title: Text(title))
        return alert
    }
}

