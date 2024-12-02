//
//  RecipeList.swift
//  PerfectMix
//
//  Created by Rui Jorge on 22/11/2024.
//

import SwiftUI

struct RecipeList: View {
    
    @EnvironmentObject var recipeViewModel: RecipeViewModel
    @State private var showDetails: Bool = false
    
    @Binding var params:String
    @Binding var value:String
    
    
    init(params: Binding<String> = .constant(""), value: Binding<String> = .constant("")) {
        _params = params
        _value = value
    }
    
    var body: some View {
        
        if !recipeViewModel.isLoading && recipeViewModel.recipes.isEmpty  {
                NoRecipesView()
                    .transition(AnyTransition.opacity.animation(.easeIn))
        }
        
        List{
            ForEach(Array(recipeViewModel.recipes.enumerated()), id: \.element.id) { index, recipe in
                RecipeListRow(recipe: recipe)
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
            recipeViewModel.getRecipes(params:params , value: value)
            
        }
        .sheet(isPresented: $showDetails){
            RecipeDetailsView()
        }
        
        if recipeViewModel.isLoading {
            LoadingView()
        }
    }
}

struct RecipeList_Previews: PreviewProvider {
    static var previews: some View {
        RecipeList(params: .constant(""), value:.constant(""))
            .environmentObject(RecipeViewModel())
    }
}
