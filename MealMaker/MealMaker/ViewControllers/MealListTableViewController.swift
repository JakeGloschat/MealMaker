//
//  MealListTableViewController.swift
//  MealMaker
//
//  Created by Jake Gloschat on 3/1/23.
//

import UIKit

class MealListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchMealsInCategory()
    }
    
    // MARK: - Properties
    var category: Category?
    var mealArray: [Meal] = []
    
    
    // MARK: - Functions
    func fetchMealsInCategory() {
        guard let category = category else { return }
        MealService.fetchmealsInCategory(forCategory: category) { [weak self] result in
            switch result {
            case .success(let meals):
                self?.mealArray = meals
                DispatchQueue.main.async { self?.tableView.reloadData() }
            case .failure(let error):
                print(error.errorDescription ?? Constants.Error.unkownError)
            }
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mealArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mealCell", for: indexPath)

        let meal = mealArray[indexPath.row]
        
        var config = cell.defaultContentConfiguration()
        config.text = meal.mealName
        config.secondaryText = meal.mealID
        cell.contentConfiguration = config

        return cell
    }
  
  
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}
