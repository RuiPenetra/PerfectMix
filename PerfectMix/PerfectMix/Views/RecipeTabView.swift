//
//  RecipeTabView.swift
//  PerfectMix
//
//  Created by Rui Jorge on 10/11/2024.
//

import SwiftUI

struct RecipeTabView: View {
    @StateObject  var recipeViewModel: RecipeViewModel = RecipeViewModel()
    

    var body: some View {
        ZStack {
            TabView {
                HomeView()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                
                RecipeListView()
                    .tabItem {
                        Image(systemName: "book")
                        Text("My Recipes")
                    }

                RecipesSavedView()
                    .tabItem {
                        Image(systemName: "bookmark")
                        Text("Saved")
                    }
            }
            
        }
        .onChange(of: recipeViewModel.isRecipeSaved) { _ in
            // Reset the flag whenever recipe is saved, if needed
            recipeViewModel.isRecipeSaved = false
        }
    }
}

struct RecipeTabView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeTabView()
            .environmentObject(RecipeViewModel())
    }
}

