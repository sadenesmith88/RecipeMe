//
//  ModifyMainInformationView.swift
//  RecipeMe
//
//  Created by sade on 4/11/24.
//

import SwiftUI

struct ModifyMainInformationView: View {
    let rowBackgroundColor = AppColor.background
    let rowForegroundColor = AppColor.foreground
    
    @Binding var mainInformation: MainInformation
    @EnvironmentObject private var recipeData: RecipeData
    
    var body: some View {
        Form {
            TextField("Recipe Name", text: $mainInformation.name)
                .listRowBackground(rowBackgroundColor)
            TextField("Author", text: $mainInformation.author)
                .listRowBackground(rowBackgroundColor)
            Section(header: Text("Description")) {
                TextEditor(text: $mainInformation.description)
                    .listRowBackground(rowBackgroundColor)
            }
            Picker(selection: $mainInformation.category, label:
            HStack {
                Text("Category")
                Spacer()
                Text(mainInformation.category.rawValue)
            }) {
                ForEach(MainInformation.Category.allCases, id: \.self) {
                    category in
                    Text(category.rawValue)
                }
            }
            .listRowBackground(rowBackgroundColor)
            .pickerStyle(MenuPickerStyle())
        }
        .foregroundColor(rowForegroundColor)
    }
}

struct ModifyMainInformationView_Previews: PreviewProvider {
    @State static var mainInfo = MainInformation(name: "Test Name", description: "Test Description", author: "Author", category: .breakfast)
    @State static var emptyInfo = MainInformation(name: "", description: "", author: "", category: .breakfast)
    static var previews: some View {
        ModifyMainInformationView(mainInformation: $mainInfo)
        ModifyMainInformationView(mainInformation: $emptyInfo)
    }
}
