//
//  The App.swift
//  Mooltitool
//
//  Created by Dmitrii Pogonia on 18.01.2024.
//

import SwiftUI

struct LogoView: View {
    @State private var showDetail = false
    var body: some View {
        HStack {
            Text("VISION")
            
            Button {
                withAnimation(.easeInOut(duration: 2)) {
                                    showDetail.toggle()
                                }
                            } label: {
                                Label("Graph", systemImage: "apple.logo")
                                    .labelStyle(.iconOnly)
                                    .imageScale(.large)
                                    .rotationEffect(.degrees(showDetail ? 90 : 0))
                                    .scaleEffect(showDetail ? 1.5 : 1)
                                    .padding()
                            }
            if showDetail {
                SampleView()
            }
        }
    }
}

struct CategoryHome: View {
    var body: some View {
        NavigationSplitView {
                    LogoView()
                .navigationTitle("Featured")
                } detail: {
                    Text("Select a Landmark")
                }
    }
}

#Preview {
    CategoryHome()
}
