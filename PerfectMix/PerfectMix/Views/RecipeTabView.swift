//
//  RecipeTabView.swift
//  PerfectMix
//
//  Created by Rui Jorge on 10/11/2024.
//

import SwiftUI

struct RecipeTabView: View {

    @StateObject var recipeViewModel: RecipeViewModel = RecipeViewModel()

    var body: some View {
            TabView {
                HomeView()
                    .navigationTitle("Ola")
                .tabItem{
                    Image(systemName: "house")
                    Text("House")
                }
                
                MyRecipesView()
                .environmentObject(recipeViewModel)
                .tabItem{
                    Image(systemName: "book")
                    Text("My Recipes")
                }
                
                RecipesSavedView()
                .tabItem{
                    Image(systemName: "bookmark")
                    Text("Saved")
                }
            }
        
    }
}

struct RecipeTabView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeTabView()
    }
}

