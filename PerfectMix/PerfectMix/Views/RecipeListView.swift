//
//  RecipeListView.swift
//  PerfectMix
//
//  Created by Rui Jorge on 10/11/2024.
//

import SwiftUI

struct RecipeListView: View {
    
    @EnvironmentObject var recipeViewModel: RecipeViewModel
    
    var body: some View {
        
        ZStack {
            if recipeViewModel.recipes.isEmpty {
                NoRecipesView()
                    .transition(AnyTransition.opacity.animation(.easeIn))
            }else{
                List{
                    ForEach(recipeViewModel.recipes){ item in
                        RecipeListRowView(recipe: item)
                            .onTapGesture {
                                withAnimation(.linear){
                                    recipeViewModel.updateItem(recipe: item)
                                }
                            }
                    }
                    .onDelete(perform: recipeViewModel.deleteItem)
                    .onMove(perform: recipeViewModel.moveItem)
                }
                
            }
        }
        .navigationTitle("Recipes")
        .navigationBarItems(
            leading: EditButton(),
            trailing:
                NavigationLink("Add", destination: NewRecipeView())
        )
        
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
