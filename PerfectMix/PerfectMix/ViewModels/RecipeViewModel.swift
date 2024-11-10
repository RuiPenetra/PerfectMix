//
//  RecipeViewModel.swift
//  PerfectMix
//
//  Created by Rui Jorge on 10/11/2024.
//

import Foundation


class RecipeViewModel: ObservableObject {
    
    @Published var recipes: [RecipeModel] = []
    
    init(){
        getItems()
    }
    
    
    func getItems(){
        let newRecipes = [
            RecipeModel(title: "This 1", isCompleted: false),
            RecipeModel(title: "This 2", isCompleted: true),
            RecipeModel(title: "This 3", isCompleted: false),
        ]
        
        recipes.append(contentsOf: newRecipes)
    }
    
    func deleteItem(indexSet: IndexSet) {
        recipes.remove(atOffsets: indexSet)
    }
    
    func moveItem(from:IndexSet, to: Int){
        recipes.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(title: String){
        let newRecipe = RecipeModel(title: title, isCompleted: false)
        recipes.append(newRecipe)
    }
    
    func updateItem(recipe: RecipeModel){
        //if let index = recipes.firstIndex { (existingRecipe) -> Bool in
            //return existingRecipe.id == recipe.id
       // } {
            //}
        
        if let index = recipes.firstIndex(where: { $0.id == recipe.id }){
            recipes[index] = RecipeModel(title: recipe.title, isCompleted: !recipe.isCompleted)
        }
        
    }
}
