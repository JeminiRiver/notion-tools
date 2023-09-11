//
//  Request.swift
//  NotionTools
//
//  Created by Jemini Willis on 9/11/23.
//

import Foundation

class Request {
	
	private let url: String
	private let method: RequestMethod
	private let content: ContentType
	
	init(url: String, method: RequestMethod, content: ContentType) {
		self.url = url;
		self.method = method
		self.content = content
	}
	
	private func call() {
		// Prepare URL
		let url = URL(string: self.url)
		guard let requestUrl = url else { fatalError() }

		// Prepare URL Request Object
		var request = URLRequest(url: requestUrl)
		request.httpMethod = self.method.rawValue

		// Set HTTP Request Body
		let params = ["product_permalink": "QMGY", "license_key": "YOUR_CUSTOMERS_LICENSE_KEY"]
		let jsonData = try? JSONEncoder().encode(params)

		request.httpBody = jsonData

		// Set HTTP Requst Header
		request.setValue(self.content.rawValue, forHTTPHeaderField: "Content-Type")
		request.setValue(self.content.rawValue, forHTTPHeaderField: "Accept")

		// Perform HTTP Request
		let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
			guard let data = data else {
				// handle no response failure
				//throw ResponseError.NoResponseFailure
				return;
			}

			print("data: \(String(describing: String(bytes: data, encoding: .utf8)))")
			guard error == nil else {
				// handle network error
				//throw ResponseError.NetworkError
				return;
			}
			do {
				// decode json data
				let decoder = JSONDecoder()
				let object = try decoder.decode(GroceryProduct.self, from: data) // <= substitute DATA_TYPE

				// handle success

			} catch let error {
				// handle json decoding error
				//throw ResponseError.DecodingError
			}
		}
		task.resume()
	}
	
}
