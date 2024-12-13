import SwiftUI

struct RecipeDetailsView: View {
    
    @EnvironmentObject var recipeViewModel: RecipeViewModel
    
    @State var askToDelete: Bool = false
    @Binding var isShowDetails: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            // Header
            Text("Details")
                .font(.title3.bold())
                .frame(maxWidth: .infinity)
                .overlay(alignment: .leading) {
                    Button(action: {
                        isShowDetails = false
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 13))
                            .foregroundColor(.black)
                    }
                    .frame(width: 35, height: 35)
                    .background(Circle().fill(Color.white))
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 4)
                    .padding(.leading, 15)
                }
                .overlay(alignment: .trailing) {
                    HStack {
                        Button(action: {
                            recipeViewModel.openEditRecipe = true
                        }) {
                            Image(systemName: "pencil")
                                .font(.system(size: 15))
                                .foregroundColor(.black)
                        }
                        .frame(width: 35, height: 35)
                        .background(Circle().fill(Color.white))
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 4)
                        .padding(.trailing, 10)
                        
                        Button(action: {
                            askToDelete = true
                        }) {
                            Image(systemName: "trash")
                                .font(.system(size: 13))
                                .foregroundColor(.black)
                        }
                        .frame(width: 35, height: 35)
                        .background(Circle().fill(Color.white))
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 4)
                        .padding(.trailing, 15)
                    }
                }
            
            // Image and HStack overlay
            ZStack(alignment: .top) {
                Image("food-placeholder")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 200)
                    .frame(maxWidth: .infinity)
                    
                    .edgesIgnoringSafeArea(.all)

                
                // HStack overlay
                VStack(spacing: 40) {
                    
                    HStack{
                        VStack(alignment: .leading, spacing: 10) {
                            Text(recipeViewModel.selectedRecipe?.title ?? "Title")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .padding(.bottom, 3)

                            RatingBar(rating: recipeViewModel.selectedRecipe?.rating ?? 0, maxRating: 5)
                        }
                        .padding(.top,20)
                        .padding()
                        
                        Spacer()
                        
                        Button(action: {
                            if recipeViewModel.savedRecipes.contains(where: { $0.id == recipeViewModel.selectedRecipe!.id }) {
                                recipeViewModel.removeRecipe(recipeViewModel.selectedRecipe!)
                            } else {
                                recipeViewModel.saveRecipe(recipeViewModel.selectedRecipe!)
                            }
                        }) {
                            Image(systemName:"bookmark.fill")
                                .font(.system(size: 20))
                                .foregroundColor(recipeViewModel.savedRecipes.contains(where: { $0.id == recipeViewModel.selectedRecipe?.id }) ? .yellow : .gray.opacity(0.4))
                        }
                        .frame(width: 45, height: 45)
                        .padding(.trailing, 15)
                    }
          
                    
                    HStack(alignment: .center, spacing: 40){
                        InfoCard(title: "Portion", image: "person.2", value: "\(recipeViewModel.selectedRecipe?.portion ?? 0) person(s)")
                        InfoCard(title: "Difficulty", image: "chart.bar", value: recipeViewModel.selectedRecipe?.difficulty ?? "Easy")
                        InfoCard(title: "Time", image: "timer", value: "\(recipeViewModel.selectedRecipe?.time ?? 1) min")
                    }
                    
                    VStack(alignment: .leading, spacing: 10){
                        Text("Description")
                            .font(.title3)
                            .fontWeight(.bold)
                        
                        Text(recipeViewModel.selectedRecipe?.description ?? "Description not available")
                            .font(.callout)
                            .foregroundColor(Color.black.opacity(0.5))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 3)
                        
                        
                        Text("Category")
                            .font(.title3)
                            .fontWeight(.bold)
                            .padding(.top,50)
                        
                        Text(recipeViewModel.selectedRecipe?.category ?? "Category")
                            .font(.callout)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 10)
                            .frame(minWidth: 100)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)
                            .background {
                                Capsule()
                                    .fill(.black.opacity(0.05))
                            }
                            .contentShape(Capsule())
                        

                    }
                    .frame(maxHeight: .infinity, alignment: .top)
                    .padding()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.horizontal)
                .background(
                    RoundedCornersShape(corners: [.topLeft, .topRight], radius: 50)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.1), radius: 30, y:-45)
                )
                .padding(.top, 160)
                
            }
            
        }
        .frame(maxHeight: .infinity)
        .padding(.top)
        .fullScreenCover(isPresented: $recipeViewModel.openEditRecipe) {
            NewRecipeView(recipe: recipeViewModel.selectedRecipe!)
        }
        .alert("Delete Recipe", isPresented: $askToDelete) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                Task {
                    await recipeViewModel.deleteRecipe(recipe: recipeViewModel.selectedRecipe!)
                }
            }
        } message: {
            Text("Are you sure you want to delete this recipe?")
        }
    }
}

// Shape for Rounded Corners
struct RoundedCornersShape: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

struct RecipeDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailsView(isShowDetails: .constant(true))
            .environmentObject(RecipeViewModel())
    }
}
