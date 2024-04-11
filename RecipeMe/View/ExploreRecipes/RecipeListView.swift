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
    let category: MainInformation.Category
    
    //default value for sheet presentation
    //trackes if modal view is currently being presented
    @State private var isPresenting = false
    @State private var newRecipe = Recipe()
    
    private let listBackgroundColor = AppColor.background
    private let listTextColor = AppColor.foreground
    
    
    var body: some View {
        NavigationView {
            List {
                //foreach must conforms to a uniquely identifiable id
                ForEach(recipes) { recipe in
                    NavigationLink(recipe.mainInfo.name, destination: RecipeDetailView(recipe: recipe))
                }
                .listRowBackground(listBackgroundColor)
                .foregroundColor(listTextColor)
            }
            .navigationTitle(navigationTitle)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isPresenting = true
                    }, label: {
                        Image(systemName: "plus")
                    })
                }
            })
            .sheet(isPresented: $isPresenting, content: {
                NavigationView {
                    ModifyRecipeView(recipe: $newRecipe)
                        .toolbar(content: {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Dismess") {
                                    isPresenting = false
                                }
                            }
                            //ensures the recipes are filled out correctly
                            ToolbarItem(placement: .confirmationAction) {
                                if newRecipe.isValid {
                                    Button("Add") {
                                        recipeData.add(recipe: newRecipe)
                                        isPresenting = false
                                    }
                                }
                            }
                        })
                        .navigationTitle("Add a New Recipe")
                }
            })
            
        }
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
