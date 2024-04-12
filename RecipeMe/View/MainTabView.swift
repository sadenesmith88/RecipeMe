//
//  MainTabView.swift
//  RecipeMe
//
//  Created by sade on 4/12/24.
//

import SwiftUI

struct MainTabView: View {
    @StateObject var recipeData = RecipeData()
    var body: some View {
TabView {
        RecipeCategoryGridView()
        .tabItem {
            Label("Recipes", systemImage: "list.dash")
        }
    NavigationView {
        RecipeListView(viewStyle: .favorites)
    }.tabItem {
        Label("Favorites", systemImage: "heart.fill")
    }
        }
.environmentObject(recipeData)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
