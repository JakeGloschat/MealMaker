//
//  Meal.swift
//  MealMaker
//
//  Created by Jake Gloschat on 3/1/23.
//

import Foundation

struct MealToplevelDictionary: Decodable {
    let meals: [Meal]
}

struct Meal: Decodable {
    private enum CodingKeys: String, CodingKey {
        case mealName = "strMeal"
        case mealImageURL = "strMealThumb"
        case mealID = "idMeal"
    }
    
    let mealName: String
    let mealImageURL: String
    let mealID: String
}
