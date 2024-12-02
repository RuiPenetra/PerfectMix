//
//  HomeView.swift
//  PerfectMix
//
//  Created by Rui Jorge on 10/11/2024.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var recipeViewModel: RecipeViewModel
    @State private var categories = ["Italian", "Chinese", "Indian", "Mexican", "Mediterranean", "Frensh"]
    
    var body: some View {
        
        ScrollView{
            VStack {
                
                Text("Welcome")
                    .font(.title)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                    Image("food-placeholder")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame( height: 160)
                        .frame(maxWidth:.infinity)
                        .overlay(
                            
                            VStack(alignment: .leading,spacing:5) {
                                Text("Recipe of the day")
                                    .font(.system(size: 14))
                                    .bold()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Text(recipeViewModel.recipeOfTheDay?.title ?? "Title")
                                    .font(.title3)
                                    .bold()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                RatingBar(rating: .constant(5), maxRating: 5)
                                
                                
                                Spacer()
                                
                            }
                                .padding()
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(Color.black)
                                .opacity(0.8)
                                .foregroundColor(Color.white)
                            
                            
                        )
                        .foregroundColor(Color.black)
                        .cornerRadius(20)
                        .shadow(radius: 14)
                    
                    
                    
                    
                    Text("Recommended")
                        .font(.title2)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top,10)
                    
                    
                    ScrollView(.horizontal, showsIndicators: false) { // Horizontal scroll
                        
                        HStack {
                            ForEach(Array(recipeViewModel.recipesRecommended.enumerated()), id: \.element.id) { index, recipe in
                                RecipeListRow(recipe: recipe)
                                    .padding(.top,20)
                                    .onTapGesture {
                                        recipeViewModel.selectedRecipe = recipe
                                        //showDetails = true
                                    }
                            }
                        }
                        .frame(maxWidth: .infinity)
                        
                    }
                    .frame(height: 300)
                    .task {
                        recipeViewModel.getRecipesRecommended()
                        
                    }
                
                
                if recipeViewModel.isLoading {
                    LoadingView()
                }
                
                Text("Categories")
                    .font(.title2)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                ScrollView(.horizontal, showsIndicators: false) { // Horizontal scroll
                    
                    HStack {
                        ForEach($categories, id: \.self) { $category in
                            RecipeCategory(category: $category)
                                .onTapGesture {
                                    recipeViewModel.categorySelected = category
                                    recipeViewModel.showRecipeListCategory.toggle()
                                }
                        }
                        .padding(4)
                        .background(Color.white)
                    }
                    .frame(maxWidth: .infinity)
                    .foregroundColor(Color.white)
                    
                    
                    
                }
                .fullScreenCover(isPresented: $recipeViewModel.showRecipeListCategory ) {
                    NavigationView{
                        
                        VStack{
                            RecipeListByCategory(value: $recipeViewModel.categorySelected)
                        }
                        .navigationBarTitle("Category: \(recipeViewModel.categorySelected)")
                    }
                }
                
                
            }
            .padding()

        }
       
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(RecipeViewModel())
    }
}
