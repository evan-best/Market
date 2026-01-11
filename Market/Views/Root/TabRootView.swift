//
//  TabRootView.swift
//  Market
//
//  Created by Evan Best on 2026-01-08.
//

import SwiftUI
import SwiftData

enum TabIdentifier: Hashable, CaseIterable {
    case home, favorites, cart, search
}

struct TabRootView: View {
	@State private var selection: TabIdentifier = .home
	
	var body: some View {
		TabView(selection: $selection) {
			Tab(value: TabIdentifier.home) {
				NavigationStack {
					HomeView()
				}
			} label: {
				Image(systemName: selection == .home ? "house.fill" : "house")
					.environment(\.symbolVariants, .none)
				Text("Home")
			}
			Tab(value: TabIdentifier.favorites) {
				NavigationStack {
					FavoritesView()
				}
			} label: {
				Image(systemName: selection == .favorites ? "heart.fill" : "heart")
					.environment(\.symbolVariants, .none)
				Text("Favorites")
			}
			Tab(value: TabIdentifier.cart) {
				NavigationStack {
					CartView()
				}
			} label: {
				Image(systemName: selection == .cart ? "cart.fill" :"cart")
					.environment(\.symbolVariants, .none)
				Text("Cart")
			}
			
			Tab(value: TabIdentifier.search, role: .search) {
				NavigationStack {
					SearchView()
				}
			} label: {
				Image(systemName: "magnifyingglass")
					.environment(\.symbolVariants, .none)
				Text("Search")
			}
		}
		.onChange(of: selection) { newValue in
			print("Selected: \(newValue)")
		}
	}
}

#Preview {
    TabRootView()
}

