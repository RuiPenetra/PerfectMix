//
//  RecipeListRowView.swift
//  PerfectMix
//
//  Created by Rui Jorge on 10/11/2024.
//

import SwiftUI

struct RecipeListRow: View {
    
    @EnvironmentObject var recipeViewModel: RecipeViewModel

    let recipe: RecipeModel
    
    var body: some View {
        ZStack{
            Color.white
                .cornerRadius(12)
            
            VStack{
                
                Image("food-placeholder")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 350,height: 270)
                    .frame(maxWidth:.infinity)
                    .cornerRadius(8)
                    .overlay{
                        VStack{
                            HStack{
                                Button(action: {
                                    if recipeViewModel.savedRecipes.contains(where: { $0.id == recipe.id }) {
                                        recipeViewModel.removeRecipe(recipe)
                                    } else {
                                        recipeViewModel.saveRecipe(recipe)
                                    }
                                }) {
                                    HStack {
                                        Image(systemName: recipeViewModel.savedRecipes.contains(where: { $0.id == recipe.id }) ? "bookmark.fill" : "bookmark")
                                            .foregroundColor(recipeViewModel.savedRecipes.contains(where: { $0.id == recipe.id }) ? .yellow : .gray)
                                    }
                                    .padding()
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(10)
                                }
                                .buttonStyle(PlainButtonStyle()) // Remove efeitos padrão
                                .contentShape(Rectangle())      // Aumenta área clicável
                                .onTapGesture { }


                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding()
                            Spacer()
                            ZStack(alignment: .bottom){
                                VStack(alignment: .leading, spacing: 10){
                                    Text(recipe.category)
                                        .font(.system(size: 12))
                                        .padding(.leading,10)
                                        .padding(.trailing,10)
                                        .padding(5)
                                        .background(Color.white.opacity(0.8))
                                        .foregroundColor(Color.black)
                                        .cornerRadius(20)
                                        
                                    Text(recipe.title)
                                        .font(.title3)
                                        .fontWeight(.bold)
                                        .padding(.bottom,3)
                                        .foregroundColor(Color.white)
                                    RatingBar(rating: .constant(5), maxRating: 5)
                                    
                                    HStack{
                                        Image(systemName: "person.fill")
                                            .aspectRatio(contentMode: .fill)
                                            .clipShape(Circle())
                                            .overlay(Circle().stroke(Color.accentColor, lineWidth: 2)
                                                        .frame(width: 25, height: 25))
                                            .foregroundColor(Color.white)
                                        Text("\(recipe.portion) persons")
                                            .font(.system(size: 15))
                                            .fontWeight(.light)
                                            .padding(.leading)
                                            .foregroundColor(Color.white)
                                        
                                        Spacer()
                                        Image(systemName: "chart.bar.fill")
                                            .font(.system(size:10))
                                            .clipShape(Circle())
                                            .overlay(Circle().stroke(Color.accentColor, lineWidth: 2)
                                                        .frame(width: 25, height: 25))
                                            .foregroundColor(Color.white)
                                        Text(recipe.difficulty)
                                            .font(.system(size: 15))
                                            .fontWeight(.light)
                                            .padding(.leading)
                                            .foregroundColor(Color.white)
                                        Spacer()
                                        Image(systemName: "timer")
                                            .font(.system(size:15))
                                            .clipShape(Circle())
                                            .overlay(Circle().stroke(Color.accentColor, lineWidth: 2)
                                                        .frame(width: 25, height: 25))
                                            .foregroundColor(Color.white)
                                        Text("\(recipe.portion) min")
                                            .font(.system(size: 15))
                                            .fontWeight(.light)
                                            .padding(.leading)
                                            .foregroundColor(Color.white)

                                    }
                                    .padding(.top,20)
                                    
                                }
                                .padding()
                                .frame(maxWidth: .infinity, maxHeight: 185, alignment: .bottom)
                                .background(Color.black.opacity(0.8))
                                .cornerRadius(20)
                                }
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)

                                .padding(5)
                        }
                      
                    
                            
                            
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
            }
            .cornerRadius(10)
        }
        .fixedSize(horizontal: false, vertical: true)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)

    }
}

struct RecipeListRow_Previews: PreviewProvider {
    
    static var item1 = RecipeModel(id:"1", title: "First item!", description: "wwwwwwwwwww", portion:0, time:20 , difficulty:"Easy", category: "Italian")
    static var item2 = RecipeModel(id:"2", title: "Second item!", description: "wwwwwwwwwww",portion:0, time:29 , difficulty:"Easy", category: "Italian")
    
    static var previews: some View {
        Group {
            RecipeListRow(recipe: item1)
            RecipeListRow(recipe: item2)
        }
        .previewLayout(.sizeThatFits)
        .environmentObject(RecipeViewModel())
    }
}
