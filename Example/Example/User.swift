//
//  User.swift
//  Example
//
//  Created by jesse on 2017/10/23.
//  Copyright © 2017年 jesse. All rights reserved.
//

import UIKit
import ObjectMapper

struct User: Mappable {
    var name: String = ""

    init?(map: Map) {}
    init() {}

    mutating func mapping(map: Map) {
        name <- map["name"]
    }
}
