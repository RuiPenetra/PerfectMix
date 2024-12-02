//
//  RecipeCategorie.swift
//  PerfectMix
//
//  Created by Rui Jorge on 22/11/2024.
//

import SwiftUI

struct RecipeCategory: View {
    
    @Binding var category: String
    
    var body: some View {
        Image("\(category.lowercased())-recipes")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth:.infinity)
            .overlay(
              
                VStack{
                    Spacer(minLength: 60)
                    Text(category)
                        .font(.system(size: 16))
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.7))
                .foregroundColor(Color.white)

                            

                
            )
            .frame(width:100, height: 100)
            .foregroundColor(Color.black)
            .cornerRadius(20)
            .shadow(radius: 14)
    }
}

struct RecipeCategory_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCategory(category: .constant("Italian"))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
