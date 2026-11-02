//
//  Main.swift
//  iChoose
//
//  Created by Dmitrii Pogonia on 04.01.2024.
//

import SwiftUI
import MapKit

struct MainView: View {
    @State private var selectedTab: Int = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            VisionView()
                .tabItem { 
                    Label("Vision", systemImage: "aqi.low") }
                .tag("1")
            GoalsView()
                .tabItem { 
                    Label("Goals", systemImage: "aqi.low") }
                .tag("2")
            HabitsView()
                .tabItem {
                    Label("Habits", systemImage: selectedTab == 4 ? "aqi.medium" : "aqi.low")
                }
                .tag("3")
            TasksView()
                .tabItem {
                    Label("Tasks", systemImage: "gear") }
                .tag("4")
            
        }
        .tabViewStyle(.automatic)
    }
}



#Preview {
    MainView()
}
