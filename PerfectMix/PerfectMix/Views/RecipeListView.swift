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
        ZStack {
            
            if hasLoaded && recipeViewModel.recipes.isEmpty {
                    NoRecipesView()
                        .transition(AnyTransition.opacity.animation(.easeIn))
                }
            
            List{
                ForEach(Array(recipeViewModel.recipes.enumerated()), id: \.element.id) { index, recipe in
                    RecipeListRowView(recipe: recipe)
                        .padding(.top,20)
                        .onTapGesture {
                            recipeViewModel.selectedRecipe = recipe
                            showDetails = true
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
            .task{
                recipeViewModel.getRecipes()
                
                hasLoaded = true
            }
            .sheet(isPresented: $showDetails){
                RecipeDetailsView()
            }
            
            if !hasLoaded && recipeViewModel.isLoading {
                LoadingView()
            }
            
   
            
        }
        .navigationTitle("My Recipes")


        
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
