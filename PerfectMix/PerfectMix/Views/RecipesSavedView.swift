//
//  RecipesSavedView.swift
//  PerfectMix
//
//  Created by Rui Jorge on 10/11/2024.
//

import SwiftUI

struct RecipesSavedView: View {
    
    @EnvironmentObject var recipeViewModel: RecipeViewModel
    
    var body: some View {
        NavigationView{
            ZStack{
                if !recipeViewModel.isLoading && recipeViewModel.recipes.isEmpty  {
                    NoRecipesView()
                        .transition(AnyTransition.opacity.animation(.easeIn))
                }
                
                List{
                    ForEach(Array(recipeViewModel.savedRecipes.enumerated()), id: \.element.id) { index, recipe in
                        RecipeListRow(recipe: recipe)
                            .padding(.top,20)
                            .onTapGesture {
                                recipeViewModel.selectedRecipe = recipe
                                recipeViewModel.showDetails = true
                                withAnimation(.linear){
                                    //recipeViewModel.updateItem(recipe: recipe)
                                }
                            }
                    }
                    //.onDelete(perform: recipeViewModel.deleteItem)
                    //.onMove(perform: recipeViewModel.moveItem)
                }
                .listStyle(.plain)
                .padding(EdgeInsets(top: 44, leading: 0, bottom: 24, trailing: 0))
                .edgesIgnoringSafeArea(.all)
                //.task{
                //  recipeViewModel.getRecipes(params:params , value: value)
                
                //}
                .sheet(isPresented: $recipeViewModel.showDetails){
                    RecipeDetailsView()
                }
                
                if recipeViewModel.isLoading {
                    LoadingView()
                }
            }
            .navigationTitle("Saved")
        }
        
        
        
    }
}

struct RecipesSavedView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            RecipesSavedView()
                .environmentObject(RecipeViewModel())
        }
    }
}
