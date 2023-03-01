//
//  Constants.swift
//  MealMaker
//
//  Created by Jake Gloschat on 3/1/23.
//

import Foundation

struct Constants {
    
    struct MealService {
        static let allCategoriesBaseURL = "https://www.themealdb.com/api/json/v1/1/categories.php"
        static let mealsInCategoryBaseURL = "https://www.themealdb.com/api/json/v1/1/filter.php"
        static let categoryQueryKey = "c"
    }
    
    struct Error {
        static let unkownError = "Unknown Error. Call Chase Hill at 867-5309"
    }
}
