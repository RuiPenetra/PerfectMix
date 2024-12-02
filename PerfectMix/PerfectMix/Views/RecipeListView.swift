//
//  RecipeListView.swift
//  PerfectMix
//
//  Created by Rui Jorge on 10/11/2024.
//

import SwiftUI

struct RecipeListView: View {
    
    @EnvironmentObject var recipeViewModel: RecipeViewModel
    @State private var hasLoaded: Bool = false
    @State private var showDetails: Bool = false

    var body: some View {
        
       VStack {
           RecipeList()
       }
       .navigationTitle("My Recipes")
       
    }
    

}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            RecipeListView()
        }
        .environmentObject(RecipeViewModel())
    }
}
