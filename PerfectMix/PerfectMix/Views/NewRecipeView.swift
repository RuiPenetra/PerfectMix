//
//  NewRecipeView.swift
//  PerfectMix
//
//  Created by Rui Jorge on 10/11/2024.
//

import SwiftUI

struct NewRecipeView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var recipeViewModel: RecipeViewModel
    @State var textFieldText: String = ""
    
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
    
    var body: some View {
        ScrollView{
            VStack {
                TextField("Type something here...", text: $textFieldText)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color.gray)
                .cornerRadius(10)
                
                Button(action: saveButtonPressed, label: {
                    Text("Save".uppercased())
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(width:200, height: 55)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                })
            }
            .padding(14)
        }
        .navigationTitle("Add in Item")
        .alert(isPresented: $showAlert, content: getAlert)
    }
    
    func saveButtonPressed(){
        recipeViewModel.addItem(title: textFieldText)
        presentationMode.wrappedValue.dismiss()
    }
    
    func getAlert() -> Alert{
        return Alert(title: Text(alertTitle))
        
    }
    
}

struct NewRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            NewRecipeView()
        }
        .environmentObject(RecipeViewModel())
    }
}
