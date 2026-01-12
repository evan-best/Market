//
//  HomeView.swift
//  Market
//
//  Created by Evan Best on 2026-01-09.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
		ScrollView {
			Text("Home")
		}
		.toolbar {
			ToolbarItem (placement: .principal) {
				Image("market-logo")
					.resizable()
					.scaledToFit()
					.foregroundStyle(Color(.accent))
					.frame(width: 100, height: 100)
			}
		}
    }
}

#Preview {
	NavigationStack {
		HomeView()
	}
}

