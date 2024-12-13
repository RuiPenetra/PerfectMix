import Foundation

class APIClient {
    
    static let shared = APIClient()
    //private let cache = NSCache<NSString, UIImage>()
    
    private var baseURL = "https://67147932690bf212c7618492.mockapi.io/api/v1/recipes"
        
    private init() {}

    // GET request to fetch all recipes or a specific recipe
    func fetchRecipes() async throws -> [RecipeModel] {
   
        do {
            guard let url = URL(string: baseURL) else {
                throw URLError(.badURL)
            }
            
            let (data, response) = try await URLSession.shared.data(from: url)
            
            // Check the status code first
            guard let httpResponse = response as? HTTPURLResponse else {
                throw URLError(.badServerResponse)
            }
            
            guard httpResponse.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }
            
            // Now proceed to decode
            let decoder = JSONDecoder()
            let recipes = try decoder.decode([RecipeModel].self, from: data)
            return recipes
        } catch {
            print("Error: \(error.localizedDescription)")
            throw URLError(.badServerResponse)
        }


    }

    func fetchRecipesFilter(params:String, value:String) async throws -> [RecipeModel] {
        
        guard var urlComponents = URLComponents(string: baseURL) else {
            throw URLError(.badURL)

        }
        urlComponents.queryItems = [
            URLQueryItem(name: params, value: value)
        ]

        guard let url = urlComponents.url else {
            throw URLError(.badURL)

        }

          var request = URLRequest(url: url)
          request.setValue("application/json", forHTTPHeaderField: "Accept")
          
        let (data, response) = try await URLSession.shared.data(from: url)
        
        do{
            // Check if the response is a 404 error
              if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 404 {
                  // Return an empty array if 404 Not Found
                  return []
              }
            
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
        
        let encoder = JSONEncoder()
        let jsonData = try encoder.encode(recipe)
        
        guard let url = URL(string: baseURL) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        print(response)
        
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 {
            let decoder = JSONDecoder()
            let postResponse = try decoder.decode(RecipeModel.self, from: data)
            return postResponse
        } else {
            throw URLError(.badServerResponse)
        }
    }
    
    
    func updateRecipe(recipe: RecipeModel) async throws -> RecipeModel {
        
        guard !recipe.id.isEmpty else {
            throw URLError(.badURL)
        }
        
        let encoder = JSONEncoder()
        let jsonData = try encoder.encode(recipe)
        
        let urlString = "\(baseURL)/\(recipe.id)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse {
            switch httpResponse.statusCode {
            case 200, 204:
                if httpResponse.statusCode == 200 {
                    let decoder = JSONDecoder()
                    let updatedRecipe = try decoder.decode(RecipeModel.self, from: data)
                    return updatedRecipe
                } else {
                    return recipe
                }
            default:
                throw URLError(.badServerResponse)
            }
        } else {
            throw URLError(.badServerResponse)
        }
    }

    
    func deleteRecipe(by id: String) async throws -> Bool {
        guard let url = URL(string: "\(baseURL)/\(id)") else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
            // Successfully fetched a single recipe
            return true
        } else {
            throw URLError(.badServerResponse)
        }
    }

}


