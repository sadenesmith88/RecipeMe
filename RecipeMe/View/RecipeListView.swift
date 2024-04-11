//
//  RecipeListView.swift
//  RecipeMe
//
//  Created by sade on 4/9/24.
//

import SwiftUI

struct RecipeListView: View {
    
    //current view and children view can access object with env obj
    @EnvironmentObject  var recipeData: RecipeData
    private let listBackgroundColor = AppColor.background
    private let listTextColor = AppColor.foreground
    let category: MainInformation.Category
    var body: some View {
        List {
            //foreach must conforms to a uniquely identifiable id
            ForEach(recipes) { recipe in
                NavigationLink(recipe.mainInfo.name, destination: RecipeDetailView(recipe: recipe))
            }
            .listRowBackground(listBackgroundColor)
            .foregroundColor(listTextColor)
        }.navigationTitle("All Recipes")
        
    }
}

extension RecipeListView {
    private var recipes: [Recipe] {
        recipeData.recipes(for: category)
    }
  
   
    
    private var navigationTitle: String {
        "\(category.rawValue) Recipes"
    }
    
}


struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RecipeListView(category: .breakfast)
                .environmentObject(RecipeData())
        }
      
    }
}
