import SwiftUI

struct MyRecipesView: View {
    @StateObject var recipeViewModel: RecipeViewModel = RecipeViewModel()
    
    var body: some View {
        NavigationView {
            RecipeListView()
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            recipeViewModel.newRecipeView = true
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                    
                }
                .sheet(isPresented: $recipeViewModel.newRecipeView){
                    NewRecipeView()
                        .navigationTitle("New Recipe")
                }
        }
    }
    
}

struct MyRecipesView_Previews: PreviewProvider {
    static var previews: some View {
        MyRecipesView()
    }
}
