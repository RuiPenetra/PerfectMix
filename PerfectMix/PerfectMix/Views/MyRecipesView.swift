import SwiftUI

struct MyRecipesView: View {
    @EnvironmentObject var recipeViewModel: RecipeViewModel

    var body: some View {
        NavigationView {
            RecipeListView()
                .fullScreenCover(isPresented: $recipeViewModel.openEditRecipe){
                    NewRecipeView()
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            recipeViewModel.openEditRecipe.toggle()
                            
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                    
                }

        }
    }
    
}

struct MyRecipesView_Previews: PreviewProvider {
    static var previews: some View {
        MyRecipesView()
            .environmentObject(RecipeViewModel())  // Pass the view model

    }
}
