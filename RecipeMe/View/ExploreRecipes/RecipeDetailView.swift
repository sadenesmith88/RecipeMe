//
//  RecipeDetailView.swift
//  RecipeMe
//
//  Created by sade on 4/9/24.
//

import SwiftUI

struct RecipeDetailView: View {
    @AppStorage("hideOptionalSteps") private var hideOptionalSteps: Bool = false
    @Binding var recipe: Recipe
    //tracks when modifyrecipeview sheet should be presented
    @State private var isPresenting = false
    @AppStorage("listBackgroundColor") private var listBackgroundColor  = AppColor.background
    @AppStorage("listTextColor") private var listTextColor  = AppColor.foreground
    var body: some View {
        VStack {
            
            HStack {
                Text("Author: \(recipe.mainInformation.author)")
                    .font(.subheadline)
                    .padding()
                Spacer()
            }
            HStack {
                Text(recipe.mainInformation
                    .description)
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
                        if direction.isOptional && hideOptionalSteps {
                            EmptyView()
                        } else {
                            HStack {
                                Text("\(index + 1). ").bold()
                                Text("\(direction.isOptional ? "(Optional) " : "")" + "\(direction.description)")
                            }.foregroundColor(listTextColor)
                        }
                        HStack {
                            let index = recipe.index(of: direction, excludingOptionalDirections: hideOptionalSteps) ?? 0
                            Text("\(index + 1). ").bold()
                            Text("\(direction.isOptional ? "(Optional) ": "")\(direction.description)")
                        }
                    }.listRowBackground(listBackgroundColor)
                }
            }
            .navigationTitle(recipe.mainInformation.name)
            .toolbar {
                ToolbarItem {
                    HStack {
                        Button("Edit") {
                            isPresenting = true
                        }
                        Button(action: {
                            recipe.isFavorite.toggle()
                        }) {
                            Image(systemName: recipe.isFavorite ? "heart.fill" : "heart")
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("")
                }
            }
            .sheet(isPresented: $isPresenting) {
                NavigationView {
                    ModifyRecipeView(recipe: $recipe)
                        .toolbar {
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Save") {
                                    isPresenting = false
                                }
                            }
                        }
                        .navigationTitle("Edit Recipe")
                }
            }
        }
    }
    
    struct RecipeDetailView_Previews: PreviewProvider {
        @State static var recipe = Recipe.testRecipes[0]
        static var previews: some View {
            NavigationView{
                RecipeDetailView(recipe: $recipe)
            }
        }
    }
}
