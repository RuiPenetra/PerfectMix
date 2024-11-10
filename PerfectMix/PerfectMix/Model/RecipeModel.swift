//
//  RecipeModel.swift
//  PerfectMix
//
//  Created by Rui Jorge on 10/11/2024.
//

import Foundation

//Immutable Struct
struct RecipeModel: Identifiable {
    let id: String
    let title: String
    let isCompleted: Bool
    
    init(id: String = UUID().uuidString,title: String, isCompleted: Bool){
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
    
    func updateCompletion() -> RecipeModel{
        return RecipeModel(id: id, title: title, isCompleted: !isCompleted)
    }
}



