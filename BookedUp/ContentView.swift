//
//  ContentView.swift
//  BookedUp
//
//  Created by Beatriz Severo on 2/11/2026.
//

import SwiftUI

struct ContentView: View {
    var onAccount: (() -> Void)? = nil

    var body: some View {
        TabView {
            Tab("Home", systemImage: "house.fill") {
                HomeView(onAccount: onAccount)
            }
            Tab("Discover", systemImage: "magnifyingglass") {
                PlaceholderView(
                    title: "Discover",
                    symbol: "magnifyingglass",
                    message: "Search and explore a curated selection of books here in a future update."
                )
            }
            Tab("Library", systemImage: "books.vertical") {
                PlaceholderView(
                    title: "My Library",
                    symbol: "books.vertical",
                    message: "Your reading shelves will live here. Saving and organising books is coming next."
                )
            }
            Tab("Stats", systemImage: "chart.bar.xaxis") {
                PlaceholderView(
                    title: "Reading Stats",
                    symbol: "chart.bar.xaxis",
                    message: "See your reading journey here once local book tracking is available."
                )
            }
        }
        .tabViewStyle(.tabBarOnly)
        .tint(AppColor.primaryText)
        .preferredColorScheme(.light)
    }
}

#Preview {
    ContentView()
}
