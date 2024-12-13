//
//  NoRecipesView.swift
//  PerfectMix
//
//  Created by Rui Jorge on 10/11/2024.
//

import SwiftUI

struct NoRecipesView: View {
    
    @State var animate: Bool = false
    
    var body: some View {
        
            VStack(spacing:10) {
                
                Image("no-recipes")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame( height: 160)
                                    
                
                Text("No recipes")
                    .font(.headline)
                    .foregroundColor(Color.black.opacity(0.6))
                    
                
                /*
                Text("Create a new recipe")
                    .padding(.bottom,20)
                
                NavigationLink(destination: NewRecipeView(recipe: RecipeModel(difficulty: "Easy", category: "Italian")), label: {
                    Text("Add")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(animate ? Color.red : Color.accentColor)
                        .cornerRadius(10)
                    
                })
                    .padding(.horizontal, animate ? 30: 50)
                    .shadow(
                        color: animate ? Color.red.opacity(0.7) : Color.accentColor.opacity(0.7),
                        radius: animate ? 30: 10,
                        x: 0,
                        y: animate ? 50:30
                    )
                    .scaleEffect(animate ? 1.1 : 1.0)
                    .offset(y: animate ? -7 : 0)
                */
            }
            .frame(maxHeight:.infinity)
            .multilineTextAlignment(.center)
            /*.onAppear(perform: addAnimation)*/
         
    }
    
    
    /*func addAnimation(){
        guard !animate else {return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
            withAnimation(
                Animation
                    .easeInOut(duration: 2.0)
                    .repeatForever()
            ){
                animate.toggle()
            }
        }
    }
     */
    
}

struct NoRecipesView_Previews: PreviewProvider {
    static var previews: some View {
        NoRecipesView()
    }
}
