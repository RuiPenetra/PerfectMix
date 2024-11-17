//
//  SwiftUIView.swift
//  PerfectMix
//
//  Created by Rui Jorge on 16/11/2024.
//

import SwiftUI

struct RecipeDetailsView: View {
    
    @EnvironmentObject var recipeViewModel: RecipeViewModel
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 20){
            
            Image("food-placeholder")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame( height: 200)
                .frame(maxWidth:.infinity)
                .cornerRadius(8)
                .overlay(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.clear, Color.accentColor]),
                        startPoint: .top,
                        endPoint: .bottom)
                        .opacity(0.4)
                        .blur(radius: 3)
                )
            
            Text(recipeViewModel.selectedRecipe?.title ?? "Title")
                .font(.title3)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            
            HStack(alignment: .center){
                VStack {
                    Text("Portion")
                        .font(.system(size: 15))
                        .bold()
                    
                    
                    HStack{
                        Image(systemName: "person.2")
                            .aspectRatio(contentMode: .fill)
                            .font(.system(size: 20))
                            .foregroundColor(Color.accentColor)
                        Text(String(recipeViewModel.selectedRecipe!.portion))
                            .font(.system(size: 15))
                        
                        
                    }
                    .padding(15)
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(radius: 1)
                }
                
                
                VStack {
                    Text("Difficulty")
                        .font(.system(size: 15))
                        .bold()
                    
                    
                    HStack{
                        Image(systemName: "chart.bar")
                            .aspectRatio(contentMode: .fill)
                            .font(.system(size: 20))
                            .foregroundColor(Color.accentColor)
                        
                        Text(recipeViewModel.selectedRecipe?.difficulty ?? "Easy")
                            .font(.system(size: 15))
                        
                        
                    }
                    .padding(15)
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(radius: 1)
                }
                
                
                VStack {
                    Text("Time")
                        .font(.system(size: 15))
                        .bold()
                    
                    
                    HStack{
                        Image(systemName: "timer")
                            .aspectRatio(contentMode: .fill)
                            .font(.system(size: 20))
                            .foregroundColor(Color.accentColor)
                        
                        
                        Text(recipeViewModel.selectedRecipe?.time ?? "1 min")
                            .font(.system(size: 15))
                        
                        
                    }
                    .padding(15)
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(radius: 1)
                }
                
            }
            .frame(maxWidth: .infinity)
            
            Text(recipeViewModel.selectedRecipe?.description ?? "1 min")
                .font(.body)
                .fontWeight(.light)
                .frame(maxWidth:.infinity,alignment: .leading)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 1)
                .padding(.horizontal)
            
            Spacer()
        }
        .background(Color("backgroundColor"))
    }
}

struct RecipeDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailsView()
    }
}
