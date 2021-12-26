//
//  Response.swift
//  NewsAppTask
//
//  Created by Mahmoud Mohamed on 24/12/2021.
//

import Foundation

struct Response<T: Codable>{
    var data: T?
    var message: String?
    var status: ResponseStatus?
}

enum ResponseStatus{
    case success, failure
}
