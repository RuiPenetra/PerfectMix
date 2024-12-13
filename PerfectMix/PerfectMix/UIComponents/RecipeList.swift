import SwiftUI

struct RecipeList: View {
    
    @EnvironmentObject var recipeViewModel: RecipeViewModel
    @State private var showDetails: Bool = false

    var body: some View {
        VStack {
            if recipeViewModel.isLoading {
                LoadingView()  // Show loading indicator
            } else if recipeViewModel.recipes.isEmpty {
                NoRecipesView()  // Show "No Recipes" message
                    .transition(AnyTransition.opacity.animation(.easeIn))
            } else {
                List {
                    ForEach(Array(recipeViewModel.recipes.enumerated()), id: \.element.id) { index, recipe in
                        RecipeListRow(recipe: recipe)
                            .padding(.top, 20)
                            .onTapGesture {
                                recipeViewModel.selectedRecipe = recipe
                                recipeViewModel.showDetails = true
                                withAnimation(.linear) {
                                    // Additional actions like updating the recipe can go here
                                }
                            }
                    }
                }
                .listStyle(.plain)
                .padding(EdgeInsets(top: 44, leading: 0, bottom: 24, trailing: 0))
                .edgesIgnoringSafeArea(.all)
            }
        }
    }
}

struct RecipeList_Previews: PreviewProvider {
    static var previews: some View {
        RecipeList()
            .environmentObject(RecipeViewModel())
    }
}
