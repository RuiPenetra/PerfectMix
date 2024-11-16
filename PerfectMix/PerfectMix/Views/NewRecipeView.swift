import SwiftUI

struct NewRecipeView: View {
    @StateObject var recipeViewModel: RecipeViewModel = RecipeViewModel()
    @State private var titleTF: String = ""
    @State private var descriptionTF: String = ""
    @State private var portionTF: String = ""
    @State private var difficulty: String = "Easy"
    @State private var cookingTime: String = "30 min"
    @State private var showAlert: Bool = false
    @State private var selectedNumber = 1  // Initial value for the number picker
    @State private var selectedTime = Date()
    
    let difficultyOptions = ["Easy", "Medium", "Hard"]
    let timeOptions = ["30 min", "1 hour", "2 hours"]
    
    // Function to show an alert
    private func getAlert() -> Alert {
        return Alert(title: Text("Saved!"), message: Text("Your recipe has been saved."), dismissButton: .default(Text("OK")))
    }
    
    private func saveButtonPressed() {
        // Here you can implement the logic to save the data (e.g., store it in a database or pass it to a view model)
        print(        recipeViewModel.newRecipeView)
        let newRecipe = RecipeModel(id:"0",title: titleTF, description: descriptionTF, portion: 0, time: cookingTime, difficulty: difficulty)
        Task {
            recipeViewModel.createRecipe(recipe: newRecipe)
            
            showAlert = true
        }
        print(        recipeViewModel.newRecipeView)

    }
    
    var body: some View {
        
        
        ScrollView {
            
            VStack {
                Text("New Recipe")
                    .font(.title)
                    .bold()
                    .padding(.top,20)
                
                Image("food-placeholder")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 200)
                    .frame(maxWidth: .infinity)
                    .opacity(0.4)
                
                
                VStack {
                    // Title TextField
                    TextField("Title", text: $titleTF)
                        .textFieldStyle(.plain)
                        .padding(.horizontal)
                        .frame(height: 55)
                        .background(Color.white)
                        .cornerRadius(10)
                    
                    // Description TextField
                    
                    TextEditor(text: $descriptionTF)
                        .textFieldStyle(.automatic)
                        .padding(10)
                        .background(Color.white)
                        .cornerRadius(10)
                        .frame(height: 120)
                        .frame(maxWidth: .infinity) // Largura máxima da tela
                        .font(.system(size: 16))
                    
                    
                    
                    
                    VStack{
                        HStack {
                            Image(systemName: "person.3")
                                .frame(width: 40)
                            
                            Text("Portion")
                                .font(.headline)
                            
                            Spacer()
                            Picker("Number", selection: $selectedNumber) {
                                // Generate a range of numbers from 1 to 100
                                ForEach(1..<20, id: \.self) { number in
                                    Text("\(number)").tag(number)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .frame(height: 100)
                            .clipped()
                            
                            Text("pearson(s)")
                                .font(.body)
                                .foregroundColor(Color.gray)
                            
                        }
                        .frame(height: 40)
                        
                        Divider()
                            .opacity(0.3)
                            .frame(height: 1)
                            .padding(5)
                        
                        HStack {
                            Image(systemName: "chart.bar")
                                .frame(width: 40)

                            Text("Difficulty")
                                .font(.headline)
                            Spacer()
                            Picker("Difficulty", selection: $difficulty) {
                                ForEach(difficultyOptions, id: \.self) { option in
                                    Text(option).tag(option)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            
                        }
                        .frame(height: 40)
                
                        Divider()
                            .opacity(0.3)
                            .frame(height: 1)
                            .padding(5)
                        
                        
                        HStack {
                            Image(systemName: "timer")
                                .frame(width: 40)

                            Text("Cooking Time")
                                .font(.headline)
                            Spacer()
                            
                            // Cooking Time Picker
                            Picker("Cooking Time", selection: $cookingTime) {
                                ForEach(timeOptions, id: \.self) { option in
                                    Text(option).tag(option)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            
                            //DatePicker("Select Time", selection: $selectedTime, displayedComponents: [.hourAndMinute])
                              //  .labelsHidden()
                               // .padding()
                               // .datePickerStyle(WheelDatePickerStyle())
                            
                        }
                        .frame(height: 40)
        
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    // Title TextField
                
                }
                .padding(10)
                
                // Save Button
                Button(action: saveButtonPressed) {
                    Text("Save".uppercased())
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(width: 250, height: 55)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                }
                .padding(.top,20)
                .padding(.bottom,20)
            }
            .padding(14)

        }
        .background(Color.gray.opacity(0.1))
        .alert(isPresented: $showAlert, content: getAlert)
        .toolbar {
            
        }
    }
}

struct NewRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NewRecipeView()
        }
    }
}
