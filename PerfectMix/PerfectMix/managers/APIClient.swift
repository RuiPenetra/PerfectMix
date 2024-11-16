import Foundation

class APIClient {
    
    static let shared = APIClient()
    //private let cache = NSCache<NSString, UIImage>()
    
    private var baseURL = "https://67147932690bf212c7618492.mockapi.io/api/v1/recipes"
        
    private init() {}



    // GET request to fetch all recipes or a specific recipe
    func fetchRecipes() async throws -> [RecipeModel] {
        guard let url = URL(string: baseURL) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        
        do{
            let decoder = JSONDecoder()
            let recipes = try decoder.decode([RecipeModel].self, from: data)
            return recipes
        }catch{
            //ERROR
            throw URLError(.badServerResponse)
        }

    }

    // GET request to fetch a single recipe by ID
    func fetchRecipe(by id: String) async throws -> RecipeModel {
        guard let url = URL(string: "\(baseURL)/\(id)") else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)
        
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
            // Successfully fetched a single recipe
            let decoder = JSONDecoder()
            let recipe = try decoder.decode(RecipeModel.self, from: data)
            return recipe
        } else {
            throw URLError(.badServerResponse)
        }
    }


    // Async function to send POST request
    func createRecipe(recipe: RecipeModel) async throws -> RecipeModel {
        // Step 1: Convert PostData to JSON
        let encoder = JSONEncoder()
        let jsonData = try encoder.encode(recipe)
        
        // Step 2: Create the URL and the URLRequest
        guard let url = URL(string: baseURL) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        // Step 3: Perform the POST request using URLSession
        let (data, response) = try await URLSession.shared.data(for: request)
        
        print(response)
        
        // Step 4: Handle the response
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 {
            // Successful response
            let decoder = JSONDecoder()
            let postResponse = try decoder.decode(RecipeModel.self, from: data)
            return postResponse
        } else {
            throw URLError(.badServerResponse)
        }
    }

}


