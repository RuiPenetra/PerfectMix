import SwiftUI

struct RecipeDetailsView: View {
    
    @EnvironmentObject var recipeViewModel: RecipeViewModel
    
    @State var askToDelete: Bool = false
    @Binding var isShowDetails:Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            Text("Details")
                .font(.title3.bold())
                .frame(maxWidth: .infinity)
                .overlay(alignment: .leading) {
                    Button {
                        isShowDetails = false
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title3)
                            .foregroundColor(.black)
                    }
                    .padding()
                }
                .overlay(alignment: .trailing) {
                    HStack{
                        Button {
                            recipeViewModel.openEditRecipe = true
                        } label: {
                            Image(systemName: "pencil")
                                .font(.title3)
                                .foregroundColor(.black)
                        }
                        .padding()
                        
                        Button {
                            
                            askToDelete = true
                        } label: {
                            Image(systemName: "trash")
                                .font(.title3)
                                .foregroundColor(.black)
                        }
                        .padding()
                    }
             
                }
            
            Image("food-placeholder")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 200)
                .frame(maxWidth: .infinity)
                .overlay {
                    ZStack {
                        LinearGradient(
                            gradient: Gradient(colors: [Color.clear, Color.black.opacity(0.5), Color.black.opacity(0.8), Color.black, Color.black]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .blur(radius: 3)

                        VStack(alignment: .leading, spacing: 10) {
                            Spacer()
                   
                            Text(recipeViewModel.selectedRecipe?.title ?? "Title")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.bottom, 3)
                            
                            RatingBar(rating: recipeViewModel.selectedRecipe?.rating ?? 0, maxRating: 5)
                        }
                        .frame(maxWidth:.infinity, alignment:.leading)
                        .padding()
                    }
                    
                }

            HStack(alignment: .center, spacing: 40) {
                InfoCard(title: "Portion", image: "person.2", value: "\(recipeViewModel.selectedRecipe?.portion ?? 0) person(s)")
                InfoCard(title: "Difficulty", image: "chart.bar", value: recipeViewModel.selectedRecipe?.difficulty ?? "Easy")
                InfoCard(title: "Time", image: "timer", value: "\(recipeViewModel.selectedRecipe?.time ?? 1) min")
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
            
            VStack{
                VStack(alignment: .leading){
                    Text("Description")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    Text(recipeViewModel.selectedRecipe?.description ?? "Description not available")
                        .font(.system(size: 14))
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .padding(.top,3)
                }
                
                Divider()
                    .padding(.top)
                
                VStack(alignment: .leading){
                    Text("Category")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    Text(recipeViewModel.selectedRecipe?.category ?? "Category")
                        .font(.callout)
                        .padding(.vertical, 8)
                        .frame(minWidth: 100)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white )
                        .background {
                            Capsule()
                                .fill(.black)
                        }
                        .contentShape(Capsule())
                
                }
                .frame(maxWidth:.infinity,alignment: .leading)
                .padding(.top)
                
            }
            .padding()


        }
        .frame(maxHeight:.infinity, alignment: .top)
        .padding(.top)
        .fullScreenCover(isPresented: $recipeViewModel.openEditRecipe){
            NewRecipeView(recipe: recipeViewModel.selectedRecipe!)
        }
        .alert("Delete Recipe", isPresented: $askToDelete) {
                 Button("Cancel", role: .cancel) { }
                 Button("Delete", role: .destructive) {
                     Task{
                        
                         await recipeViewModel.deleteRecipe(recipe: recipeViewModel.selectedRecipe!)
                         
                     }
                 }
             } message: {
                 Text("Are you sure you want to delete this recipe?")
             }
    }
    
}

struct RecipeDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailsView(isShowDetails: .constant(true))
            .environmentObject(RecipeViewModel())
    }
}
