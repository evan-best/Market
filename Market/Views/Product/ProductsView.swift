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
		Image(systemName: "tag")
			.font(.system(size: 120))
			.frame(width: 250, height: 250)
			.foregroundStyle(.secondary)

		Text(category.name)
		Text(category.slug)
		Text(String(category.id))
    }
}

#Preview {
	ProductsView(category: Category(slug: "electronics", name: "Electronics", url: "https://picsum.photos/id/10/200/200"))
}
