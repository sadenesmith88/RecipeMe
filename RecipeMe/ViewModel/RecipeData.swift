//
//  RecipeData.swift
//  RecipeMe
//
//  Created by sade on 4/9/24.
//
import Foundation

class RecipeData: ObservableObject {
  @Published var recipes = Recipe.testRecipes
  
  func recipes(for category: MainInformation.Category) -> [Recipe] {
    var filteredRecipes = [Recipe]()
      for recipe in recipes {
          if recipe.mainInfo.category == category {
              filteredRecipes.append(recipe)
      }
    }
      return filteredRecipes
  }
}
