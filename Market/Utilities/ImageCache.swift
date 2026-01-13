//
//  ImageCache.swift
//  weevva-swiftui
//
//  Created by Evan Best on 2025-11-19.
//

import SwiftUI

class ImageCache {
	static let shared = ImageCache()
	private var cache = NSCache<NSURL, UIImage>()

	private init() {
		cache.countLimit = 100
		cache.totalCostLimit = 1024 * 1024 * 100 // 100 MB
	}

	func get(url: URL) -> UIImage? {
		return cache.object(forKey: url as NSURL)
	}

	func set(_ image: UIImage, for url: URL) {
		cache.setObject(image, forKey: url as NSURL)
	}
}

struct CachedAsyncImage<Content: View>: View {
	let url: URL?
	@ViewBuilder let content: (AsyncImagePhase) -> Content

	@State private var phase: AsyncImagePhase = .empty

	var body: some View {
		content(phase)
			.task {
				await loadImage()
			}
	}

	private func loadImage() async {
		guard let url = url else {
			phase = .empty
			return
		}

		// Check cache first
		if let cachedImage = ImageCache.shared.get(url: url) {
			phase = .success(Image(uiImage: cachedImage))
			return
		}

		// Load from network
		do {
			let (data, _) = try await URLSession.shared.data(from: url)
			if let uiImage = UIImage(data: data) {
				ImageCache.shared.set(uiImage, for: url)
				phase = .success(Image(uiImage: uiImage))
			} else {
				phase = .failure(NSError(domain: "ImageCache", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid image data"]))
			}
		} catch {
			phase = .failure(error)
		}
	}
}
