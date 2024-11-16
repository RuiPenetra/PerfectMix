//
//  PerfectMixApp.swift
//  PerfectMix
//
//  Created by Rui Jorge on 10/11/2024.
//

import SwiftUI

@main
struct PerfectMixApp: App {
    
    @StateObject var recipeViewModel: RecipeViewModel = RecipeViewModel()

    var body: some Scene {
        WindowGroup {
            RecipeTabView()
                .environmentObject(recipeViewModel)
        
        }
    }
}
