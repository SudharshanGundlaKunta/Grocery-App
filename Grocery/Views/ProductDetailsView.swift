//
//  ProductDetailsView.swift
//  Grocery
//
//  Created by Apple on 16/08/24.
//

import SwiftUI
import TipKit

struct ProductDetailsView: View {
    
    @ObservedObject var cart = Cart.shared
    @State var showDesription = false
    var product: Product
    let bgCOlor = Color(red: 225 / 255, green: 224 / 255, blue: 238 / 255)
    let naturalProductData = ["Vegan", "Natural", "Neutral"]
    let naturalImages = ["tree.fill", "atom", "camera.macro"]
    var roundRating = 0
    var numberOfHlafStars: Int {
        return (5.0 - product.rating) > 0.0 ? 1 : 0
    }
    var numberOfEmptyStars: Int {
        numberOfHlafStars > 0 ? 5 - (numberOfHlafStars + roundRating) : 5 - Int(product.rating)
    }
    
    var informationTip = InformationTip()
    
    init(product: Product) {
        self.product = product
        roundRating = Int(product.rating)
    }
    
    var body: some View {
        ZStack {
            VStack {
                
                nameAndInfoView
                
                imageView
                
                floatingView
                
                Spacer()

                bottomDetailsView
            }
            .ignoresSafeArea(edges: /*@START_MENU_TOKEN@*/.bottom/*@END_MENU_TOKEN@*/)
        }
        .background(bgCOlor)
        
        
    }
    
    var nameAndInfoView: some View {
        HStack {
            Text(product.title)
                .font(.title)
                .fontWeight(.medium)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                .padding()
            
            Image(systemName: "info.circle")
                .popoverTip(informationTip, arrowEdge: .bottom, action: { action in
                    
                })
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .padding()
                .onTapGesture {
                    informationTip.invalidate(reason: .actionPerformed)
                    showDesription.toggle()
                }
                .sheet(isPresented: $showDesription, content: {
                    
                    MoreInfoView(product: product)
                })
                
        }
    }
    
    var floatingView: some View {
        HStack {
            ForEach(0..<3) { index in
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .fill(Color.white)
                    .frame(width: 80, height: 80)
                    .overlay {
                        
                        VStack {
                            Image(systemName: naturalImages[index])
                                .resizable()
                                .frame(width: 30, height: 30)
                            
                            Text(naturalProductData[index])
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                    }
                    .contextMenu {
                        Text("This is just for Implementation")
                            .font(.headline)
                            .foregroundStyle(Color.white)
                    }
                    
                    
            }
        }
        .padding()
    }
    
    var bottomDetailsView: some View {
        RoundedRectangle(cornerRadius: 30.0)
            .fill(Color.white)
            .frame(height: 250)
            .overlay {
                VStack {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(product.title)
                                .font(.title2)
                                .fontWeight(.semibold)
                            Text("size: 4.23 ft oz/ 125ml")
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        VStack(alignment: .trailing) {
                            
                            starRatingView
                            
                            Text("\(product.reviews.count) Reviews")
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .foregroundColor(.gray)
                        }
                        
                        
                    }
                    
                    Spacer()
                    
                    HStack {
                        Text(product.price.convertToDollers())
                            .font(.title)
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        
                        HStack(spacing: 8) {
                            Button {
                                cart.removeItem(product)
                            }label: {
                                Text("-")
                                    .frame(width: 30, height: 30, alignment: .center)
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
                                    .frame(width: 30, height: 30, alignment: .center)
                                    .background(Color.orange)
                                    .font(.subheadline)
                                    .foregroundStyle(Color.white)
                                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            }
                        }
                        .padding(4)
                        .overlay {
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.gray, lineWidth: 2)
                        }
                        .padding(.trailing)
                        
                        NavigationLink {
                            CartView()
                        } label: {
                            Text("Cart")
                                .padding(.all, 4)
                                .padding(.horizontal)
                                .font(.title3)
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                                .background(Color.black)
                                .cornerRadius(15)
                        }

                        
                    }
                    
                    Spacer()
                    
                }
                .padding(.all, 20)
            }
    }
    
    var starRatingView: some View {
        
        HStack(spacing: 0) {
           
            ForEach(0..<roundRating) { _ in
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
            
            ForEach(0..<numberOfHlafStars) { _ in
                Image(systemName: "star.leadinghalf.filled")
                    .foregroundColor(.yellow)
            }
            
            ForEach(0..<numberOfEmptyStars) { _ in
                Image(systemName: "star")
                    .foregroundColor(.yellow)
            }
            

        }
    }
    
    var imageView: some View {
        
        AsyncImage(url: URL(string: product.images.first ?? "")) { image in
            
            image
                .resizable()
                .scaledToFit()
                .background(bgCOlor)
                .padding(.top)
                
            
        } placeholder: {
            Image(systemName: "photo.artframe")
                .resizable()
                .foregroundColor(.gray.opacity(0.5))
                .fontWeight(.thin)
                .scaledToFit()
                .background(bgCOlor)
                .overlay(alignment: .center) {
                    ProgressView()
                        .colorMultiply(.blue)
                        .font(.largeTitle)
                }
                .padding(.horizontal)
                
        }
    }
}



#Preview {
    DashboardView()
}
