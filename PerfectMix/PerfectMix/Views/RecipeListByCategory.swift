//
//  RecipeListByCategory.swift
//  PerfectMix
//
//  Created by Rui Jorge on 22/11/2024.
//
import SwiftUI

struct RecipeListByCategory: View {
    
    @EnvironmentObject var recipeViewModel: RecipeViewModel
    @Binding var isShowCategory: Bool
    @Binding var category: String
    @State private var showDetails = false

    var body: some View {
        NavigationView{

            VStack {
                if recipeViewModel.isLoading {
                    LoadingView()  // Show loading indicator
                } else {
                    RecipeList()  // Show RecipeList
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button(action: {
                                    recipeViewModel.showRecipeListCategory = false  // Dismiss this cover
                                }) {
                                    Text("Back")
                                        .foregroundColor(Color.accentColor)
                                }
                            }
                        }
                        .fullScreenCover(isPresented: $recipeViewModel.showDetails) {
                            RecipeDetailsView(isShowDetails: $recipeViewModel.showDetails)  // Show Recipe Details on tap
                        }

                }
            }
            .onAppear {
                recipeViewModel.getRecipes(params: "category", value: category)  // Fetch recipes by category
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        isShowCategory = false
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 13))
                            .foregroundColor(.black)
                            .padding(.leading,6)// Cor do ícone (pode ser ajustada)
                    }
                    .frame(width: 35, height: 35)
                    .background(Circle().fill(Color.white))
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 4)
                    .scaleEffect(isShowCategory ? 1.1 : 1)
                    .animation(.easeInOut(duration: 0.2), value: isShowCategory)
                    .padding(.bottom,10)


                }
            }
            .navigationBarTitle("Category: \(category)")

        }
        //.toast(isPresented: $recipeViewModel.isRecipeSaved, message: recipeViewModel.message)


    }
}

struct RecipeListByCategory_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListByCategory(isShowCategory: .constant(true) ,category: .constant("Italian"))
            .environmentObject(RecipeViewModel())
    }
}
