//
//  RatingBar.swift
//  PerfectMix
//
//  Created by Rui Jorge on 22/11/2024.
//

import SwiftUI

struct RatingBar: View {
    @Binding var rating: Int  // Binding variable to update the rating
    let maxRating: Int       // Maximum number of stars (e.g., 5 stars)
    
    var body: some View {
        HStack {
            ForEach(1..<maxRating + 1, id: \.self) { index in
                Image(systemName: index <= rating ? "star.fill" : "star")
                    .foregroundColor(index <= rating ? .yellow : .gray)
                    .font(.system(size: 14))  // Adjust the size of the stars
                    .onTapGesture {
                        rating = index  // Set rating when star is tapped
                    }
                    .padding(.zero)
            }
        }
    }
}

struct RatingBar_Previews: PreviewProvider {
    static var previews: some View {
        RatingBar(rating: .constant(3), maxRating: 5)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
