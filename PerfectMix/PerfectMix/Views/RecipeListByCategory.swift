//
//  RecipeListByCategory.swift
//  PerfectMix
//
//  Created by Rui Jorge on 22/11/2024.
//

import SwiftUI

struct RecipeListByCategory: View {
    
    @Binding var value:String
    @EnvironmentObject var recipeViewModel: RecipeViewModel

    var body: some View {
        RecipeList(params: .constant("category"), value: $value)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        recipeViewModel.showRecipeListCategory.toggle()
                    }) {
                        
                        Text("Back")
                            .foregroundColor(Color.accentColor)
                    }
                }
                
            }

    }
}

struct RecipeListByCategory_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListByCategory(value: .constant(""))
    }
}
