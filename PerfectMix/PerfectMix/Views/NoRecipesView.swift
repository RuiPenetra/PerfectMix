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
        ScrollView{
            VStack(spacing:10) {
                Text("There are no recipes")
                    .font(.title)
                    .fontWeight(.semibold)
                
                Text("I think you should fuck off")
                    .padding(.bottom,20)
                
                NavigationLink(destination: NewRecipeView(), label: {
                    Text("Add .l. ")
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
                
            }
            .multilineTextAlignment(.center)
            .padding(40)
            .onAppear(perform: addAnimation)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    
    func addAnimation(){
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
    
}

struct NoRecipesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            NoRecipesView()
            .navigationTitle("Title")
        }
    }
}
