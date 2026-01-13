//
//  ProductsView.swift
//  Market
//
//  Created by Evan Best on 2026-01-11.
//

import SwiftUI

struct ProductsView: View {
	var category: Category
	
    var body: some View {
		AsyncImage(url: URL(string: category.image)) { phase in
			switch phase {
			case .empty:
				ProgressView()
					.frame(width: 120, height: 120)

			case .success(let image):
				image
					.resizable()
					.scaledToFit()

			case .failure:
				Image(systemName: "photo")
					.font(.largeTitle)
					.foregroundStyle(.secondary)

			@unknown default:
				EmptyView()
			}
		}
		.frame(width: 250, height: 250)

		Text(category.name)
		Text(category.slug)
		Text(String(category.id))
    }
}

#Preview {
    ProductsView(category: Category(id: 1, name: "Electronics", image: "https://picsum.photos/300", slug: "electronics"))
}
