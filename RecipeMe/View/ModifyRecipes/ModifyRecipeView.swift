//
//  ModifyRecipeView.swift
//  RecipeMe
//
//  Created by sade on 4/10/24.
//

import SwiftUI

struct ModifyRecipeView: View {
    //@Binding means this view does not own the variable
    //recipelistview will provide all the info needed to modify recipes
    @Binding var recipe: Recipe
    var body: some View {
        Button("Fill in the recipe with test data.") {
            recipe.mainInfo = MainInformation(name: "test", description: "test", author: "test", category: .dinner)
            recipe.directions = [Direction(description: "test", isOptional: false)]
            recipe.ingredients = [Ingredient(name: "test", quantity: 1.0, unit: .none)]
        }
    }
}

struct ModifyRecipeView_Previews: PreviewProvider {
    //must contain a binding to correctly disply modifyrecipeview since its structure contains a binding variable
    @State static var recipe = Recipe()
    static var previews: some View {
        ModifyRecipeView(recipe: $recipe)
    }
}
