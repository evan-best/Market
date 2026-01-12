//
//  TabRootView.swift
//  Market
//
//  Created by Evan Best on 2026-01-08.
//

import SwiftUI
import SwiftData

enum TabIdentifier: Hashable, CaseIterable {
    case home, saved, bag, profile, search
}

struct TabRootView: View {
	@State private var selection: TabIdentifier = .home
	
	var body: some View {
		TabView(selection: $selection) {
			Tab("Home", image: "home", value: .home) {
				NavigationStack {
					HomeView()
				}
			}
			
			Tab("Favorites", image: "saved", value: .saved) {
				NavigationStack {
					FavoritesView()
				}
			}
			
			Tab("Bag", image: "bag", value: .bag) {
				NavigationStack {
					CartView()
				}
			}
			
			Tab("Search", image: "search", value: .search, role: .search) {
				NavigationStack {
					SearchView()
				}
			}
		}
	}
}

#Preview {
    TabRootView()
}

