//
//  RecipeDetailView.swift
//  RecipeMe
//
//  Created by sade on 4/9/24.
//

import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    private let listBackgroundColor = AppColor.background
    private let listTextColor = AppColor.foreground
    var body: some View {
        VStack {
            HStack {
                Text("Author: \(recipe.mainInfo.author)")
                    .font(.subheadline)
                    .padding()
                Spacer()
            }
            HStack {
                Text(recipe.mainInfo.description)
                    .font(.subheadline)
                    .padding()
                Spacer()
            }
            List {
                Section(header: Text("Ingredients")) {
                    //./self is a unique identifier for each ingredient
                    ForEach(recipe.ingredients.indices, id: \.self) { index in
                        let ingredient = recipe.ingredients[index]
                        Text(ingredient.description)
                            .foregroundColor(listTextColor)
                    }
                }.listRowBackground(listBackgroundColor)
                Section(header: Text("Directions")) {
                    ForEach(recipe.directions.indices, id: \.self) { index in
                        let direction = recipe.directions[index]
                        HStack {
                        Text("\(index + 1). ").bold()
                        Text("\(direction.isOptional ? "(Optional) " : "")" + "\(direction.description)")
                        }.foregroundColor(listTextColor)
                    }
                }.listRowBackground(listBackgroundColor)
            }
        }
        .navigationTitle(recipe.mainInfo.name)
    }
}


struct RecipeDetailView_Previews: PreviewProvider {
    @State static var recipe = Recipe.testRecipes[0]
    static var previews: some View {
        NavigationView{
            RecipeDetailView(recipe: recipe)
        }
    }
}
