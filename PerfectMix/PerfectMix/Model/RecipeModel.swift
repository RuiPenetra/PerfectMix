//
//  RecipeModel.swift
//  PerfectMix
//
//  Created by Rui Jorge on 10/11/2024.
//

import Foundation

//Immutable Struct
struct RecipeModel: Identifiable, Decodable, Encodable{
    let id: String
    let title: String
    let description: String
    let portion: Int
    let time: String
    let difficulty: String
    
    
    struct RecipeModelResponse: Decodable {
        let request: [RecipeModel]
    }

    
    init(id: String,title: String, description: String, portion:Int, time:String, difficulty:String){
        self.id = id
        self.title = title
        self.description = description
        self.portion = portion
        self.time = time
        self.difficulty =  difficulty
    }
    
    func updateCompletion() -> RecipeModel{
        return RecipeModel(id: id, title: title, description: description, portion: portion, time: time, difficulty: difficulty )
    }
    
    func generateSingleMockRecipe() -> RecipeModel {
        return RecipeModel(
            id: "1",
            title: "Spaghetti Carbonara",
            description: "Classic Italian pasta with eggs, cheese, pancetta, and pepper.",
            portion: 2,
            time: "30 min",
            difficulty: "Easy"
        )
    }
}



