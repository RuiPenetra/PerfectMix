//
//  PerfectMixApp.swift
//  PerfectMix
//
//  Created by Rui Jorge on 10/11/2024.
//

import SwiftUI

@main
struct PerfectMixApp: App {
    
    @StateObject var recipeListViewModel: RecipeViewModel = RecipeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                RecipeListView()
            }
            .environmentObject(recipeListViewModel)
        }
    }
}
