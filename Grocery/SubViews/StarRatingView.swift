//
//  StarRatinView.swift
//  Grocery
//
//  Created by Apple on 25/08/24.
//

import SwiftUI

struct StarRatingView: View {
    
    let topRating = 5
    var currentRating: Int
    var EmptyStarCount: Int {
        topRating - currentRating
    }
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<currentRating) { _ in
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
            
            ForEach(0..<EmptyStarCount) { _ in
                Image(systemName: "star.fill")
                    .foregroundColor(.gray)
            }
            
            Text("(\(currentRating))")
        }
    }
}
