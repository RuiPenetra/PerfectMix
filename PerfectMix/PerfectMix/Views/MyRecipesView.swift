import SwiftUI

struct MyRecipesView: View {
    @EnvironmentObject var recipeViewModel: RecipeViewModel

    var body: some View {
        NavigationView {
            RecipeListView()
                .sheet(isPresented: $recipeViewModel.newRecipeView){
                    NewRecipeView()
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            recipeViewModel.changeStateNewRecipeV()
                            
                            print(recipeViewModel.newRecipeView )
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
    }
}
