//
//  RecipeListByCategory.swift
//  PerfectMix
//
//  Created by Rui Jorge on 22/11/2024.
//
import SwiftUI

struct RecipeListByCategory: View {
    
    @EnvironmentObject var recipeViewModel: RecipeViewModel
    @Binding var category: String
    @State private var showDetails = false

    var body: some View {
            VStack {
                if recipeViewModel.isLoading {
                    LoadingView()  // Show loading indicator
                } else {
                    RecipeList()  // Show RecipeList
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button(action: {
                                    recipeViewModel.showRecipeListCategory = false  // Dismiss this cover
                                }) {
                                    Text("Back")
                                        .foregroundColor(Color.accentColor)
                                }
                            }
                        }
                        .fullScreenCover(isPresented: $recipeViewModel.showDetails) {
                            RecipeDetailsView(isShowDetails: $recipeViewModel.showDetails)  // Show Recipe Details on tap
                        }
                        .toast(isPresented: $recipeViewModel.isRecipeSaved, message: recipeViewModel.message)

                }
            }
            .onAppear {
                recipeViewModel.getRecipes(params: "category", value: category)  // Fetch recipes by category
            }
        

    }
}

struct RecipeListByCategory_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListByCategory(category: .constant("Italian"))
    }
}
