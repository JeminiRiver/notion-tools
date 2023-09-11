//
//  Methods.swift
//  NotionTools
//
//  Created by Jemini Willis on 9/11/23.
//

import Foundation

enum RequestMethod: String {
	case GET
	case POST
	case PUT
	case DELETE
	case OPTION
}
	
enum ContentType: String {
	case json = "application/json"
	case xml = "application/xml"
}
