//
//  YQJTarget.swift
//  Example
//
//  Created by jesse on 2017/10/23.
//  Copyright © 2017年 jesse. All rights reserved.
//

import UIKit
import CandyMoya

enum YQJTarget {
    case orders(currentPage: Int, perPage: Int, headers: [String: String])
}

extension YQJTarget: CandyTarget {
    var baseURL: URL {
        return URL(string: "http://test-order.yiqijiao.net")!
    }

    var route: CandyRoute {
        switch self {
        case .orders(let currentPage, let perPage, _):
            return .get("/users/orders/\(currentPage)/\(perPage)")
        }
    }

    var parameters: [String : Any]? {
        switch self {
        case .orders(let currentPage, let perPage, _):
            return ["currentPage": currentPage, "perPage": perPage]
        }
    }

    var defaultParams: [String : Any]? {
        return ["session_id": "0fsoDBsp9Y9DUVbP6bTo9C8S7oicO7vsozDPk9ke9bBWhWes74RgO4kZj93rbe6m"]
    }

    var httpHeaderFields: [String : String]? {
        switch self {
        case .orders(_, _, let headers):
            return headers
        }
    }

    var defaultHeaderFields: [String : String]? {
        switch self {
        case .orders:
            return ["X-APP-KEY":"r4k5gf8wusnd72mftq96wkchp3jzg54h","X-WitWork-Product":"yqj-app", "YQJ-APP-USER-SESSION-ID": "0fsoDBsp9Y9DUVbP6bTo9C8S7oicO7vsozDPk9ke9bBWhWes74RgO4kZj93rbe6m"]
        }
    }
}

