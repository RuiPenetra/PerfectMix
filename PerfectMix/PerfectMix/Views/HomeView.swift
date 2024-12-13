//
//  HomeView.swift
//  PerfectMix
//
//  Created by Rui Jorge on 10/11/2024.
//
import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var recipeViewModel: RecipeViewModel
    private var categories = ["Italian", "Chinese", "Indian", "Mexican", "Mediterranean", "French"]
    @State private var categorySelected: String = ""  // Make this a @State property
    @State private var showDetails = false
    @State private var showCategories = false
    
    var body: some View {
        VStack {
            Text("Welcome")
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            // Show LoadingView while recipes are being loaded
            if recipeViewModel.isLoading {
                LoadingView()  // Show loading view until recipes are loaded
            } else {
                // Show content when recipes are finished loading
                VStack {
                    Image("food-placeholder")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 160)
                        .frame(maxWidth: .infinity)
                        .overlay(
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Recipe of the day")
                                    .font(.system(size: 14))
                                    .bold()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Text(recipeViewModel.recipeOfTheDay?.title ?? "Title")
                                    .font(.title3)
                                    .bold()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                RatingBar(rating: recipeViewModel.recipeOfTheDay?.rating ?? 0, maxRating: 5)
                                
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
                        .onTapGesture {
                            recipeViewModel.selectedRecipe = recipeViewModel.recipeOfTheDay
                            showDetails = true
                        }
                    
                    Text("Recommended")
                        .font(.title2)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 10)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(Array(recipeViewModel.recipesRecommended.enumerated()), id: \.element.id) { index, recipe in
                                RecipeListRow(recipe: recipe)
                                    .padding(.top, 20)
                                    .onTapGesture {
                                        recipeViewModel.selectedRecipe = recipe
                                        showDetails = true
                                    }
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .frame(height: 300)
                    
                    Text("Categories")
                        .font(.title2)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 10)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(categories, id: \.self) { category in
                                Button(action: {
                                    categorySelected = category  // Update the selected category
                                    showCategories = true
                                }) {
                                    RecipeCategory(category: category)
                                }
                            }
                            .padding(4)
                            .background(Color.white)
                        }
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Color.white)
                    }
                }
                    .transition(.opacity)
            
            }
        }
        .padding()
        .onAppear {
            recipeViewModel.isRecipeSaved = false
            if recipeViewModel.recipesRecommended.isEmpty {
                Task{
                    await recipeViewModel.getRecipesRecommended()  // Load recommended recipes when view appears
                }
            }

        }
        .onDisappear {
            recipeViewModel.isRecipeSaved = false // Reset when view disappears
        }
        .fullScreenCover(isPresented: $showDetails) {
            RecipeDetailsView(isShowDetails: $showDetails)
        }
        .fullScreenCover(isPresented: $showCategories) {
            RecipeListByCategory(isShowCategory: $showCategories,category: $categorySelected)  // Pass Binding<String> here

        }
        .toast(isPresented: $recipeViewModel.isRecipeSaved, message: recipeViewModel.message)

        }

    }


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(RecipeViewModel())
    }
}
