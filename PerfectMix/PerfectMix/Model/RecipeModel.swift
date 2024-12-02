//
//  RecipeModel.swift
//  PerfectMix
//
//  Created by Rui Jorge on 10/11/2024.
//

import Foundation

//Immutable Struct
struct RecipeModel: Identifiable, Decodable, Encodable{
    var id: String
    var title: String
    var description: String
    var portion: Int
    var time: Int
    var difficulty: String
    var category: String
    
    
    struct RecipeModelResponse: Decodable {
        let request: [RecipeModel]
    }

    
    init(
         id: String = "",
         title: String = "",
         description: String = "",
         portion: Int = 1,
         time: Int = 1,
         difficulty: String = "",
         category: String = ""
     ) {
         self.id = id
         self.title = title
         self.description = description
         self.portion = portion
         self.time = time
         self.difficulty = difficulty
         self.category = category
     }
    

    func updateCompletion() -> RecipeModel{
        return RecipeModel(id: id, title: title, description: description, portion: portion, time: time, difficulty: difficulty, category: category)
    }
    
    func generateSingleMockRecipe() -> RecipeModel {
        return RecipeModel(
            id: "1",
            title: "Spaghetti Carbonara",
            description: "Classic Italian pasta with eggs, cheese, pancetta, and pepper.",
            portion: 2,
            time: 10,
            difficulty: "Easy",
            category: "Italian"
        )
    }
}



