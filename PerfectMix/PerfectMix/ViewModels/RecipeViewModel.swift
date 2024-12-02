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
    
    @Published var showDetails: Bool = false
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
    
    
    func getRecipesRecommended() {
        isLoading = true
        Task {
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
    }
    func createRecipe(recipe: RecipeModel) async -> Bool {
        do {
            try await APIClient.shared.createRecipe(recipe: recipe)
            return true
        } catch {
            print("Erro ao carregar receitas: \(error)")
            return false
        }
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
            recipes[index] = RecipeModel(id: recipe.id, title: recipe.title, description: recipe.description, portion: recipe.portion, time: recipe.time, difficulty: recipe.difficulty, category: recipe.category)
        }
        
    }
    
    
    
    func saveRecipe(_ recipe: RecipeModel) {
           // Verifica se a receita já está salva
           if !savedRecipes.contains(where: { $0.id == recipe.id }) {
               savedRecipes.append(recipe)
               saveToFile()
           }
       }
       
       func removeRecipe(_ recipe: RecipeModel) {
           // Remove a receita da lista
           savedRecipes.removeAll(where: { $0.id == recipe.id })
           saveToFile()
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
       
    private func loadSavedRecipes() {
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
