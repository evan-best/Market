//
//  CategoryButton.swift
//  Market
//
//  Created by Evan Best on 2026-01-11.
//

import SwiftUI

struct CategoryButton: View {
	let category: Category
	var action: (() -> Void)? = nil

	var body: some View {
		VStack(spacing: 8) {
			AsyncImage(url: URL(string: category.image)) { phase in
				switch phase {
				case .empty:
					ProgressView()
						.frame(width: 72, height: 72)
					
				case .success(let image):
					image
						.resizable()
						.scaledToFill()
						.frame(width: 72, height: 72)
						.clipShape(Circle())
						.glassEffect()
					
				case .failure:
					Image(systemName: "tag")
						.frame(width: 72, height: 72)
						.foregroundStyle(.secondary)
					
				@unknown default:
					EmptyView()
				}
			}
			
			Text(category.name)
				.font(.subheadline)
				.fontWeight(.medium)
				.lineLimit(1)
		}
		.padding(.vertical, 2)
		.padding(.horizontal, 2)
	}
}

#Preview {
	CategoryButton(
		category: Category(
			id: 1,
			name: "Electronics",
			image: "https://picsum.photos/id/10/200/200", slug: "electronics"
		)
	) {
		print("Category tapped")
	}
	.padding()
	.background(Color(.systemBackground))
}
