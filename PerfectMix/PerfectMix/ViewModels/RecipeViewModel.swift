//
//  RecipeViewModel.swift
//  PerfectMix
//
//  Created by Rui Jorge on 10/11/2024.
//

import Foundation


@MainActor final class RecipeViewModel: ObservableObject {
    
    @Published var recipes: [RecipeModel] = []
    @Published var recipesRecommended: [RecipeModel] = []
    @Published var showRecipeListCategory: Bool = false
    @Published var openEditRecipe: Bool = false
    @Published var isLoading: Bool = false
    @Published var selectedRecipe: RecipeModel?
    @Published var recipeOfTheDay: RecipeModel?
    @Published var categorySelected:String = ""
    @Published var savedRecipes: [RecipeModel] = []
    @Published var isRecipeSaved: Bool = false
    @Published var showDetails: Bool = false
    @Published var recipeDeleted: Bool = false
    @Published var message: String = ""
    
    private let fileName = "savedRecipes.json"
    
    
    init(){
        loadSavedRecipes()
    }
    
    
    
    func getRecipes(params:String,value:String) {
        isLoading = true
        Task {
            do {
                if params == "" && value == ""{
                    recipes = try await APIClient.shared.fetchRecipes()
                }else{
                    recipes = try await APIClient.shared.fetchRecipesFilter(params:params, value:value)

                }
                isLoading = false
            } catch {
                print("Erro ao carregar receitas: \(error)")
                isLoading = false
            }
        }
    }
    
    
    func getRecipesRecommended() async {
        isLoading = true
            do {
                
                let recipes = try await APIClient.shared.fetchRecipes()
                
                recipeOfTheDay = recipes.first!
                recipesRecommended=recipes.dropLast(recipes.count-4)
                isLoading = false
            } catch {
                print("Erro ao carregar receitas: \(error)")
                isLoading = false
            }
        
    }
    func createRecipe(recipe: RecipeModel) async -> Bool {
        isLoading = true
        do {
            let response = try await APIClient.shared.createRecipe(recipe: recipe)
            
            recipes.append(response)
            isLoading = false
            return true
        } catch {
            print("Erro ao carregar receitas: \(error)")
            isLoading = false
            return false
        }
    }

    func updateRecipe(recipe: RecipeModel) async -> Bool {
        do {
            isLoading = true
            // Attempt to update the recipe
            let updatedRecipe = try await APIClient.shared.updateRecipe(recipe: recipe)
            
            // Update the selected recipe if needed
            if selectedRecipe?.id == updatedRecipe.id {
                selectedRecipe = updatedRecipe
            }

            // A helper function to update the recipe in multiple lists
            updateRecipeInLists(updatedRecipe: updatedRecipe)
            
            // Call the helper function to update all lists
            updateRecipeInLists(updatedRecipe: updatedRecipe)
            
            // Update the recipe of the day if it matches
            if recipeOfTheDay?.id == updatedRecipe.id {
                recipeOfTheDay = updatedRecipe
            }
            isLoading = false

            return true
        } catch {
            print("Error updating recipe: \(error)")
            isLoading = false
            return false
        }
    }
    
    func deleteRecipe(recipe: RecipeModel) async -> Bool {
        do {
            isLoading = true
            // Attempt to update the recipe
            let _ = try await APIClient.shared.deleteRecipe(by: recipe.id)
      
            
            // Update the recipe of the day if it matches
            if recipeOfTheDay?.id == recipe.id {
                recipeOfTheDay = nil
            }
            
            deleteRecipeInLists(deletedRecipe: recipe)
            
            showDetails.toggle()
            
            isLoading = false
            return true
        } catch {
            print("Error updating recipe: \(error)")
            isLoading = false
            return false
        }
        
    }

    func updateRecipeInLists(updatedRecipe: RecipeModel) {
        // Update in recipes list
        if let index = recipes.firstIndex(where: { $0.id == updatedRecipe.id }) {
            recipes[index] = updatedRecipe
        }
        
        // Update in savedRecipes list
        if let index = savedRecipes.firstIndex(where: { $0.id == updatedRecipe.id }) {
            savedRecipes[index] = updatedRecipe
        }
        
        // Update in recipesRecommended list
        if let index = recipesRecommended.firstIndex(where: { $0.id == updatedRecipe.id }) {
            recipesRecommended[index] = updatedRecipe
        }
        
    }
    
    func deleteRecipeInLists(deletedRecipe: RecipeModel){
        
        if let index = recipes.firstIndex(where: { $0.id == deletedRecipe.id }) {
            recipes.remove(at: index) // Remove from recipes
        }

        // Remove from savedRecipes list
        if let index = savedRecipes.firstIndex(where: { $0.id == deletedRecipe.id }) {
            savedRecipes.remove(at: index) // Remove from savedRecipes
        }
        
        if let index = recipesRecommended.firstIndex(where: { $0.id == deletedRecipe.id }) {
            recipesRecommended.remove(at: index)
            recipesRecommended = recipes.count > 4 ? recipes.dropLast(recipes.count - 4) : recipes
        }
        recipeOfTheDay = recipes.first!

    }

    
    func updateItem(recipe: RecipeModel){
        //if let index = recipes.firstIndex { (existingRecipe) -> Bool in
            //return existingRecipe.id == recipe.id
       // } {
            //}
        
        if let index = recipes.firstIndex(where: { $0.id == recipe.id }){
            recipes[index] = RecipeModel(id: recipe.id, title: recipe.title, description: recipe.description, portion: recipe.portion, time: recipe.time, difficulty: recipe.difficulty, category: recipe.category)
        }
        
    }
    
    
    
        func saveRecipe(_ recipe: RecipeModel) {
           // Verifica se a receita já está salva
           if !savedRecipes.contains(where: { $0.id == recipe.id }) {
               savedRecipes.append(recipe)
               saveToFile()
               //isRecipeSaved = true
               //message = "Recipe has been saved"
           }
        }
       
       func removeRecipe(_ recipe: RecipeModel) {
           // Remove a receita da lista
           savedRecipes.removeAll(where: { $0.id == recipe.id })
           saveToFile()
           //isRecipeSaved = true
           //message = "Recipe has been removed"

           
       }
       
       private func saveToFile() {
           guard let url = getFileURL() else { return }
           
           do {
               let data = try JSONEncoder().encode(savedRecipes)
               try data.write(to: url)
               print("Recipes saved to file.")
           } catch {
               print("Error saving recipes to file: \(error)")
           }
       }
       

    func loadSavedRecipes() {
        guard let url = getFileURL() else { return }
        
        // Check if file exists before loading
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: url.path) {
            // If file doesn't exist, create it with an empty array
            savedRecipes = []
            saveToFile() // Optionally, save an empty array to the file
            print("No saved recipes file found, starting with an empty list.")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            savedRecipes = try JSONDecoder().decode([RecipeModel].self, from: data)
            print("Recipes loaded from file.")
        } catch {
            print("Error loading recipes from file: \(error)")
        }
    }

       
       private func getFileURL() -> URL? {
           let fileManager = FileManager.default
           guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
               print("Could not find documents directory.")
               return nil
           }
           return documentsDirectory.appendingPathComponent(fileName)
       }

}
