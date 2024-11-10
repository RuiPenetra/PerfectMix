//
//  RecipeListRowView.swift
//  PerfectMix
//
//  Created by Rui Jorge on 10/11/2024.
//

import SwiftUI

struct RecipeListRowView: View {
    
    let recipe: RecipeModel
    
    var body: some View {
        HStack{
            Image(systemName: recipe.isCompleted ? "checkmark.circle" : "circle")
                .foregroundColor(recipe.isCompleted ? .green : .red)
            Text(recipe.title)
            Spacer()
        }
        .font(.title2)
        .padding(.vertical, 8)
    }
}

struct RecipeListRowView_Previews: PreviewProvider {
    
    static var item1 = RecipeModel(title: "First item!", isCompleted: false)
    static var item2 = RecipeModel(title: "Second item!", isCompleted: true)
    
    static var previews: some View {
        Group {
            RecipeListRowView(recipe: item1)
            RecipeListRowView(recipe: item2)
        }
        .previewLayout(.sizeThatFits)
    }
}
