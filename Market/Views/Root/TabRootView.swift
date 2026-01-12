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
			
			Tab("", image: "home", value: .home) {
				NavigationStack {
					HomeView()
				}
			}
			
			Tab("", image: "saved", value: .saved) {
				NavigationStack {
					FavoritesView()
				}
			}
			
			Tab("", image: "bag", value: .bag) {
				NavigationStack {
					BagView()
				}
			}
			
			Tab("", image: "profile", value: .profile) {
				NavigationStack {
					ProfileView()
				}
			}
			
			Tab("", image: "search", value: .search, role: .search) {
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

