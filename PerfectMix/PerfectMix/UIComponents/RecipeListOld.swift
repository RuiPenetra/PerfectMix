//
//  RecipeListRowView.swift
//  PerfectMix
//
//  Created by Rui Jorge on 10/11/2024.
//

import SwiftUI

struct RecipeListOld: View {
    
    let recipe: RecipeModel
    
    var body: some View {
        ZStack{
            Color.white
                .cornerRadius(12)
            
            VStack{
                
                Image("food-placeholder")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame( height: 120)
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
                
                VStack(alignment: .leading, spacing: 10){
                    Text(recipe.title)
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.bottom,3)
                    Text(recipe.description)
                        .font(.body)
                        .lineLimit(2)
                        .truncationMode(.tail)
                        .opacity(0.6)
                    Spacer()
                    HStack{
                        Image(systemName: "person.fill")
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.accentColor, lineWidth: 2)
                                        .frame(width: 25, height: 25))
                            .foregroundColor(Color.black.opacity(0.6))
                        Text(String(recipe.portion))
                            .font(.system(size: 15))
                            .fontWeight(.light)
                            .padding(.leading)
                        
                        Spacer()
                        Image(systemName: "chart.bar.fill")
                            .font(.system(size:10))
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.accentColor, lineWidth: 2)
                                        .frame(width: 25, height: 25))
                            .foregroundColor(Color.black.opacity(0.6))
                        Text(recipe.difficulty)
                            .font(.system(size: 15))
                            .fontWeight(.light)
                            .padding(.leading)
                        Spacer()
                        Image(systemName: "timer")
                            .font(.system(size:15))
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.accentColor, lineWidth: 2)
                                        .frame(width: 25, height: 25))
                            .foregroundColor(Color.black.opacity(0.6))
                        Text(String(recipe.time))
                            .font(.system(size: 15))
                            .fontWeight(.light)
                            .padding(.leading)
                    }
                    
                }
                .padding()
            }
            .cornerRadius(10)
            .padding(.vertical, 8)
        }
        .fixedSize(horizontal: false, vertical: true)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)

    }
}

struct RecipeListOld_Previews: PreviewProvider {
    
    static var item1 = RecipeModel(id:"1", title: "First item!", description: "wwwwwwwwwww", portion:0, time:20, difficulty:"Easy",category: "Italian")
    static var item2 = RecipeModel(id:"2", title: "Second item!", description: "wwwwwwwwwww",portion:0, time:29, difficulty:"Easy",category: "Italian")
    
    static var previews: some View {
        Group {
            RecipeListOld(recipe: item1)
            RecipeListOld(recipe: item2)
        }
        .previewLayout(.sizeThatFits)
    }
}
