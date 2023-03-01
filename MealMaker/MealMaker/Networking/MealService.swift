//
//  MealService.swift
//  MealMaker
//
//  Created by Jake Gloschat on 3/1/23.
//

import Foundation

struct MealService {
    
    static func fetchAllCategories(completion: @escaping (Result<[Category], NetworkError>) -> Void) {
        guard let finalURL = URL(string: Constants.MealService.allCategoriesBaseURL) else { completion(.failure(.invalidURL)) ; return }
        print("Fetch All Categories Final URL: \(finalURL)")
        
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            if let error = error {
                completion(.failure(.thrownError(error)))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("Fetch All Categories Status Code: \(response.statusCode)")
            }
            
            guard let data = data else { completion(.failure(.noData)) ; return }
                
            do {
                let topLevel = try JSONDecoder().decode(CategoryTopLevelDictionary.self, from: data)
                completion(.success(topLevel.categories))
            } catch {
                completion(.failure(.unableToDecode))
                return
            }
        }.resume()
    }
    
    static func fetchmealsInCategory(forCategory category: Category, completion: @escaping(Result<[Meal], NetworkError>) -> Void) {
        
        guard let baseURL = URL(string: Constants.MealService.mealsInCategoryBaseURL) else { completion(.failure(.invalidURL)) ; return }
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let categoryQueryItem = URLQueryItem(name: Constants.MealService.categoryQueryKey, value: category.categoryName)
        urlComponents?.queryItems = [categoryQueryItem]
        guard let finalURL = urlComponents?.url else { completion(.failure(.invalidURL)) ; return }
        print("Fetch Meals in Category Final URL: \(finalURL)")
        
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            if let error = error {
                completion(.failure(.thrownError(error)))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("Fetch Meals in Category Status Code: \(response.statusCode)")
            }
            
            guard let data = data else { completion(.failure(.noData)) ; return }
            
            do {
                let topLevel = try JSONDecoder().decode(MealToplevelDictionary.self, from: data)
                completion(.success(topLevel.meals))
            } catch {
                completion(.failure(.unableToDecode))
                return
            }
        }.resume()
    }
}
