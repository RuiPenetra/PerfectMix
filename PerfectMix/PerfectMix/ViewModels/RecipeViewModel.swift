//
//  RecipeViewModel.swift
//  PerfectMix
//
//  Created by Rui Jorge on 10/11/2024.
//

import Foundation


@MainActor final class RecipeViewModel: ObservableObject {
    
    @Published var recipes: [RecipeModel] = []
    @Published var showTabView = true
    @Published var newRecipeView = false
    @Published var isLoading = false
    
    
    init(){ }
    
    
    func getRecipes() {
        isLoading = true
        Task {
            do {
                recipes = try await APIClient.shared.fetchRecipes()
                isLoading = false
            } catch {
                print("Erro ao carregar receitas: \(error)")
                isLoading = false
            }
        }
    }

    func createRecipe(recipe: RecipeModel) {
        //let newRecipe = RecipeModel(title: title, description: description, portion: portion, time: time, difficulty: difficulty, isCompleted: false)
        //try await APIClient().createPost(recipe: recipe)
        newRecipeView = false

        Task {
            do {
                try await APIClient.shared.createRecipe(recipe: recipe)
                //isLoading = false
            } catch {
                print("Erro ao carregar receitas: \(error)")
                //isLoading = false
            }
        }
    }
    
    func changeStateTab(){
        showTabView.toggle()
    }
    
    func deleteItem(indexSet: IndexSet) {
        recipes.remove(atOffsets: indexSet)
    }
    
    func moveItem(from:IndexSet, to: Int){
        recipes.move(fromOffsets: from, toOffset: to)
    }
    

    
    func updateItem(recipe: RecipeModel){
        //if let index = recipes.firstIndex { (existingRecipe) -> Bool in
            //return existingRecipe.id == recipe.id
       // } {
            //}
        
        if let index = recipes.firstIndex(where: { $0.id == recipe.id }){
            recipes[index] = RecipeModel(id: recipe.id, title: recipe.title, description: recipe.description, portion: recipe.portion, time: recipe.time, difficulty: recipe.difficulty)
        }
        
    }
}
