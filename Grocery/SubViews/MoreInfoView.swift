//
//  SwiftUIView.swift
//  Grocery
//
//  Created by Apple on 25/08/24.
//

import SwiftUI

struct MoreInfoView: View {
    
    let product: Product
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 16){
                Text("Description")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .fontDesign(.rounded)
                
                Text(product.description)
                    .foregroundColor(.gray)
                    .font(.subheadline)
                    .fontWeight(.regular)
                
                Text("Reviews")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .fontDesign(.rounded)
                
                ForEach(product.reviews, id: \.reviewerName) { review in
                    
                    VStack(alignment: .leading){
                        HStack {
                            
                            Image("Profile")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                
                                
                                
                            
                            VStack(alignment: .leading) {
                                Text(review.reviewerName)
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .fontDesign(.rounded)
                                
                                Text(review.date.convertToDate)
                                    .font(.caption)
                                    .fontWeight(.thin)
                                    .fontDesign(.rounded)
                                    .foregroundColor(.gray)
                                
                            }
                            
                            Spacer()
                             
                            StarRatingView(currentRating: review.rating)
                            
                        }
                        
                        Text("\(review.comment). Although the product is very pretty and good looking in the app it doesn't resembles like in the app in real time. Anyhow I love shoing in this application beacuase of the animations in the Application")
                            .font(.subheadline)
                            .fontWeight(.regular)
                            
                    }
                    
                }
            }
            
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            .padding()
            .cornerRadius(25)
            .presentationDetents([.fraction(0.50), .fraction(0.85)])
            .presentationDragIndicator(.visible)
            
        }
        .safeAreaPadding([.top])
    }
}

