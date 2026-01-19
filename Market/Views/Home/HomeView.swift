//
//  HomeView.swift
//  Market
//
//  Created by Evan Best on 2026-01-09.
//

import SwiftUI

struct HomeView: View {
	@State private var vm = HomeViewModel()
	@State private var searchText: String = ""
	@State private var path: [Product] = []

	@Namespace private var animation

	var body: some View {
		ScrollView {
			VStack(alignment: .leading, spacing: 6) {

				HStack {
					Text("Shop by Category")
						.font(.title2)
						.bold()
					Spacer()
					Button {
						
					} label: {
						Text("See All")
					}
				}
				.padding(.horizontal)

				// Categories
				ScrollView(.horizontal, showsIndicators: false) {
					HStack(spacing: 12) {
						ForEach(vm.categoryVM.categories.prefix(6)) { category in
							NavigationLink(destination: ProductsView(category: category)) {
								CategoryButton(category: category)
							}
							.buttonStyle(.plain)
						}
					}
					.padding(.horizontal)
				}

				Spacer(minLength: 16)
				
				// Top Picks
				if !vm.topPicks.isEmpty {
					HStack {
						Text("Picked for You")
							.font(.title2)
							.bold()
						Spacer()
					}
					.padding(.horizontal)
					ProductGrid(
						products: vm.topPicks,
						animation: animation
					)
					.padding(.horizontal)
				}

				Spacer(minLength: 16)
			}
			.padding(.top, 8)
		}
		.scrollClipDisabled(true)
		.task {
			await vm.load()
		}
		.searchable(text: $searchText, placement: .navigationBarDrawer)
		.toolbar {
			ToolbarItem(placement: .principal) {
				Image("market-logo")
					.resizable()
					.scaledToFit()
					.frame(width: 86, height: 86)
			}
		}
		.navigationBarTitleDisplayMode(.inline)
		.navigationDestination(for: Product.self) { product in
			ProductDetailView(product: product)
				.navigationTransition(.zoom(sourceID: product.id, in: animation))
		}
	}
}

#Preview {
	NavigationStack {
		HomeView()
	}
}

