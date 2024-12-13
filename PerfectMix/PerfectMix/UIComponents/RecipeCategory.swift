//
//  RecipeCategorie.swift
//  PerfectMix
//
//  Created by Rui Jorge on 22/11/2024.
//

import SwiftUI

struct RecipeCategory: View {
    
    var category: String
    
    var body: some View {
        Image("\(category.lowercased())-recipes")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth:.infinity)
            .overlay(
                ZStack{
                    LinearGradient(
                        gradient: Gradient(colors: [Color.clear, Color.black, Color.black]),
                        startPoint: .top,
                        endPoint: .bottom)
                        .opacity(0.8)
                        .blur(radius: 3)
                
                VStack{
                    
                    Spacer(minLength: 60)
                    Text(category)
                        .font(.system(size: 16))
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .foregroundColor(Color.white)

                            
                }
                
            )
            .frame(width:100, height: 100)
            .foregroundColor(Color.black)
            .cornerRadius(20)
    }
}

struct RecipeCategory_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCategory(category: "Italian")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
