//
//  Errors.swift
//  NotionTools
//
//  Created by Jemini Willis on 9/11/23.
//

import Foundation

enum ResponseError: Error {
	case NoResponseFailure
	case NetworkError
	case DecodingError
}
