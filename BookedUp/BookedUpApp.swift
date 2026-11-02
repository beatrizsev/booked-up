//
//  BookedUpApp.swift
//  BookedUp
//
//  Created by Beatriz Severo on 2/11/2026.
//

import SwiftUI

@main
struct BookedUpApp: App {
    init() {
        AppTypography.registerFonts()
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(named: "SageGreen")
        UIPageControl.appearance().pageIndicatorTintColor = UIColor(named: "PaperCream")
    }

    var body: some Scene {
        WindowGroup {
            AppRootView()
        }
    }
}
