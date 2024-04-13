//
//  SettingsView.swift
//  RecipeMe
//
//  Created by sade on 4/12/24.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("hideOptionalSteps") private var hideOptionalSteps: Bool = false
    //AppStorage stores what user assigns so they dont have to keep updating to their liking whenever they open the app
    @AppStorage("listBackgroundColor") private var listBackgroundColor = AppColor.background
    @AppStorage("listTextColor") private var listTextColor = AppColor.foreground
   
    var body: some View {
        NavigationView {
            Form {
                ColorPicker("List BackgroundColor", selection: $listBackgroundColor)
                    .padding()
                    .listRowBackground(listBackgroundColor)
                ColorPicker("Text Color", selection: $listTextColor)
                    .padding()
                    .listRowBackground(listBackgroundColor)
                Toggle("Hide Optional Steps", isOn: $hideOptionalSteps)
                    .padding()
                    .listRowBackground(listBackgroundColor)
            }
            .foregroundColor(listTextColor)
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
