//
//  ProductHeroPager.swift
//  Market
//
//  Created by Evan Best on 2026-01-12.
//

import SwiftUI

struct ProductHeroPager: View {
	let imageURLStrings: [String]

	@State private var currentIndex: Int = 0

	private var urls: [URL] {
		imageURLStrings.compactMap { URL(string: $0) }
	}

	private var heroHeight: CGFloat { 320 }

	var body: some View {
		ZStack(alignment: .bottomTrailing) {
			RoundedRectangle(cornerRadius: 18, style: .continuous)
				.fill(.quaternary.opacity(0.35))

			if urls.isEmpty {
				placeholder
			} else {
				TabView(selection: $currentIndex) {
					ForEach(Array(urls.enumerated()), id: \.offset) { index, url in
						GeometryReader { geo in
							AsyncImage(url: url) { phase in
								switch phase {
								case .empty:
									loading(width: geo.size.width, height: geo.size.height)
								case .success(let image):
									image
										.resizable()
										.interpolation(.high)
										.scaledToFill()
										.frame(width: geo.size.width, height: geo.size.height)
										.clipped()
								case .failure:
									failure(width: geo.size.width, height: geo.size.height)
								@unknown default:
									failure(width: geo.size.width, height: geo.size.height)
								}
							}
						}
						.tag(index)
					}
				}
				.tabViewStyle(.page(indexDisplayMode: .automatic))
			}

			if urls.count > 1 {
				indexPill(current: currentIndex + 1, total: urls.count)
					.padding(12)
			}
		}
		.frame(height: heroHeight)
		.clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
		.padding(.horizontal)
	}

	private var placeholder: some View {
		ZStack {
			Image(systemName: "photo")
				.font(.largeTitle)
				.foregroundStyle(.secondary)
		}
	}

	private func loading(width: CGFloat, height: CGFloat) -> some View {
		ZStack {
			Rectangle()
				.fill(.quaternary.opacity(0.25))
			ProgressView()
		}
		.frame(width: width, height: height)
	}

	private func failure(width: CGFloat, height: CGFloat) -> some View {
		ZStack {
			Rectangle()
				.fill(.quaternary.opacity(0.25))
			Image(systemName: "photo")
				.font(.largeTitle)
				.foregroundStyle(.secondary)
		}
		.frame(width: width, height: height)
	}

	private func indexPill(current: Int, total: Int) -> some View {
		Text("\(current) / \(total)")
			.font(.caption.weight(.semibold))
			.padding(.horizontal, 10)
			.padding(.vertical, 6)
			.background(.ultraThinMaterial)
			.clipShape(Capsule())
	}
}
