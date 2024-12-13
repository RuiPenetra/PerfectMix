//
//  RecipeListView.swift
//  PerfectMix
//
//  Created by Rui Jorge on 10/11/2024.
//

import SwiftUI

struct RecipeListView: View {
    
    @EnvironmentObject var recipeViewModel: RecipeViewModel
    @State private var hasLoaded: Bool = false
    @State private var showDetails: Bool = false

    var body: some View {
        NavigationView {
            ZStack{
                RecipeList()
                    .onAppear {
                        recipeViewModel.getRecipes(params: "", value: "")
                    }
                    .toast(isPresented: $recipeViewModel.isRecipeSaved, message: recipeViewModel.message)

            }
            .navigationTitle("My Recipes")
             .fullScreenCover(isPresented: $recipeViewModel.showDetails) {
                 RecipeDetailsView(isShowDetails: $recipeViewModel.showDetails)  // Show Recipe Details on tap
             }
             .toolbar {
                 ToolbarItem(placement: .navigationBarTrailing) {
                     Button {
                         recipeViewModel.openEditRecipe.toggle()
                         
                     } label: {
                         Image(systemName: "plus")
                     }
                 }
                 
             }
        }

    }
    

}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            RecipeListView()
        }
        .environmentObject(RecipeViewModel())
    }
}
