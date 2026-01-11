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
		.scrollEdgeEffectStyle(.automatic, for: .top)
		.toolbar {
			ToolbarItem (placement: .principal) {
				Image("market-logo")
					.resizable()
					.scaledToFit()
					.foregroundStyle(Color(.accent))
					.frame(width: 120, height: 120)
			}
		}
    }
}

#Preview {
	NavigationStack {
		HomeView()
	}
}

