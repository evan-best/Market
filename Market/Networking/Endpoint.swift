//
//  Endpoint.swift
//  Market
//
//  Created by Evan Best on 2026-01-08.
//

import Foundation

struct Endpoint {
	let path: String
	var queryItems: [URLQueryItem] = []
	
	init(path: String, queryItems: [URLQueryItem] = []) {
		self.path = path
		self.queryItems = queryItems
	}
}
