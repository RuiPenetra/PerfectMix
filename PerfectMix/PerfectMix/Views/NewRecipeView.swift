//
//  NewRecipeView.swift
//  PerfectMix
//
//  Created by Rui Jorge on 02/12/2024.
//

import SwiftUI
struct NewRecipeView: View {
    @EnvironmentObject var recipeViewModel: RecipeViewModel
    @State var recipe: RecipeModel
    @Namespace var animation
    @State private var showAlert: Bool = false
    @State private var showValidationAlert: Bool = false

    let categories: [String] = ["Italian", "Chinese", "Indian", "Mexican", "Mediterranean", "French"]

    private func getAlert() -> Alert {
        return Alert(
            title: Text("Saved!"),
            message: Text("Your recipe has been \(recipe.id.isEmpty ? "Created" : "Updated")."),
            dismissButton: .default(Text("OK")) {
                recipeViewModel.openEditRecipe.toggle()
            })
    }

    private func getValidationAlert() -> Alert {
        return Alert(
            title: Text("Validation Error"),
            message: Text("Please fill in all fields."),
            dismissButton: .default(Text("OK")) {
            })
    }

    // Validation function
    private func validateFields() -> Bool {
        return !recipe.title.isEmpty &&
               !recipe.description.isEmpty &&
               recipe.portion > 0 &&
               recipe.time > 0 &&
               !recipe.difficulty.isEmpty &&
               !recipe.category.isEmpty
    }

    var body: some View {
        VStack(spacing: 12) {
            Text("\(recipeViewModel.selectedRecipe == nil ? "New" : "Edit") Recipe")
                .font(.title3.bold())
                .frame(maxWidth: .infinity)
                .overlay(alignment: .leading) {
                    Button(action: {
                        recipeViewModel.openEditRecipe = false
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 13))
                            .foregroundColor(.black)
                    }
                    .frame(width: 35, height: 35)
                    .background(Circle().fill(Color.white))
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 4)
                    .scaleEffect(recipeViewModel.openEditRecipe ? 1.1 : 1)
                    .animation(.easeInOut(duration: 0.2), value: recipeViewModel.openEditRecipe)
                    .padding(.bottom,10)
            
                }

            VStack(alignment: .leading, spacing: 12) {
                Text("Title")
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
                
                TextField("", text: $recipe.title)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 10)
            }
            .padding(.top, 30)

            Divider()

            VStack(alignment: .leading, spacing: 12) {
                Text("Description")
                    .font(.system(size: 16))
                    .foregroundColor(.gray)

                TextEditor(text: $recipe.description)
                    .frame(height: 120)
                    .frame(maxWidth: .infinity)
            }
            .padding(.top)

            Divider()

            HStack(alignment: .center, spacing: 12) {
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Image(systemName: "person.2")
                            .font(.system(size: 15))
                        
                        Text("Portion")
                            .font(.system(size: 16))

                    }
                    .foregroundColor(.gray)

                    HStack {
                        TextField("", value: $recipe.portion, format: .number)
                            .padding(.vertical, 10)
                            .multilineTextAlignment(.center)
                            .keyboardType(.numberPad)

                        HStack {
                            Spacer()
                            Text("person(s)")
                                .fontWeight(.thin)
                                .padding(.trailing, 10)
                        }
                    }
                }
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Image(systemName: "timer")
                            .font(.system(size: 15))
                        
                        Text("Cooking Time")
                            .font(.system(size: 16))
                    }
                    .foregroundColor(.gray)

                    HStack {
                        TextField("", value: $recipe.time, format: .number)
                            .padding(.vertical, 10)
                            .multilineTextAlignment(.center)
                            .keyboardType(.numberPad)

                        HStack {
                            Spacer()
                            Text("min")
                                .fontWeight(.thin)
                                .padding(.trailing, 10)
                        }
                    }
                }
            }
            .padding(.top)

            Divider()

            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(systemName: "chart.bar")
                        .font(.system(size: 15))
                    
                    Text("Difficulty")
                        .font(.system(size: 16))
                }
                .foregroundColor(.gray)

                let difficultyOptions = ["Easy", "Medium", "Hard"]

                Picker("Difficulty", selection: $recipe.difficulty) {
                    ForEach(difficultyOptions, id: \.self) { option in
                        Text(option).tag(option)
                            .foregroundColor(Color.black)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .foregroundColor(Color.black)
            }
            .frame(maxWidth: .infinity)
            .padding(.top)

            Divider()

            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(systemName: "tag")
                        .font(.system(size: 15))
                    
                    Text("Category")
                        .font(.system(size: 16))
               }
                .foregroundColor(.gray)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(categories, id: \.self) { category in
                            Text(category)
                                .font(.callout)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 10)
                                .frame(minWidth: 100)
                                .multilineTextAlignment(.center)
                                .foregroundColor(recipe.category == category ? .white : .black)
                                .background {
                                    if recipe.category == category {
                                        Capsule()
                                            .fill(.black)
                                            .matchedGeometryEffect(id: "CATEGORY", in: animation)
                                    } else {
                                        Capsule()
                                            .strokeBorder(.black)
                                    }
                                }
                                .contentShape(Capsule())
                                .onTapGesture {
                                    withAnimation {
                                        recipe.category = category
                                    }
                                }
                        }
                    }
                    .padding(.horizontal)
                }
                
                Divider()
                
                Button {
                    if validateFields() {
                       Task {
                           var response: Bool = false
                           if (recipe.id.isEmpty){
                               response = await recipeViewModel.createRecipe(recipe: recipe)
                           }else{
                               response = await recipeViewModel.updateRecipe(recipe: recipe)
                           }
                           
                           if response{
                               showAlert = true
                           }
                       }
                   } else {
                       showValidationAlert = true
                   }
                } label: {
                    Text("Save Recipe")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .foregroundColor(.white)
                        .background(Capsule().fill(Color.black)) // Correct usage of background modifier
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
                .padding(.bottom, 10)
            }
            .frame(maxWidth: .infinity)
            .padding(.top)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
        .alert(isPresented: Binding<Bool>(
            get: { showAlert || showValidationAlert },
            set: { newValue in
                if !newValue {
                    showAlert = false
                    showValidationAlert = false
                }
            }
        )) {
            if showValidationAlert {
                return getValidationAlert()
            } else {
                return getAlert()
            }
        }

    }
}

struct NewRecipeView_Previews: PreviewProvider {
    @State static var previewRecipe = RecipeModel(difficulty: "Easy", category: "Italian")

    static var previews: some View {
        NewRecipeView(recipe: previewRecipe)
            .environmentObject(RecipeViewModel())
    }
}
