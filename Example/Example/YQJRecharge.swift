//
//  YQJRechargeModel.swift
//  Yiqijiao
//
//  Created by jesse on 2017/9/7.
//  Copyright © 2017年 yiqijiao. All rights reserved.
//

import UIKit
import ObjectMapper
import CandyExtension

enum YQJRechargeInfoType {
    case recharge
    case consume
}

extension YQJRechargeInfoType {
    var info: String {
        switch self {
        case .recharge:
            return "购买详情"
        default:
            return "消费详情"
        }
    }
    
    var payment: String {
        switch self {
        case .recharge:
            return "购买支付"
        default:
            return "消费支付"
        }
    }
}

struct YQJRechargeRecord: Mappable {
    var coins: String = "0.00"
    var rechargeRecords = [YQJSubRechargeRecord]()
    var consumeRecords = [YQJSubConsumeRecord]()
    
    init?(map: Map) {}
    init() {}
    
    mutating func mapping(map: Map) {
        let transform = TransformOf<String, Int>(fromJSON: { (value: Int?) -> String in
            guard let value = value else { return "0.00" }
            return String(format: "%.2f", value.cgFloat / 100.0)
        }, toJSON: { (value: String?) -> Int? in
            return 0
        })
        
        coins               <- (map["coins"], transform)
        consumeRecords      <- map["trades"]
        rechargeRecords     <- map["orders"]
    }
}

struct YQJSubRechargeRecord: Mappable {
    var uuid: String = ""
    var goods_name: String = ""
    var content: String = ""
    var type: Int = 0
    var actual_amount: Int = 0
    var total_amount: Int = 0
    var created_at: Int = 0
    var payment_sp: Int = 0
    var payment_sp_text: String = ""
    var status: String = ""
    var info: YQJRechargeInfo!
    
    init?(map: Map) {}
    init() {}
    
    mutating func mapping(map: Map) {
        uuid                <- map["uuid"]
        goods_name          <- map["goods_name"]
        content             <- map["content"]
        type                <- map["type"]
        actual_amount       <- map["actual_amount"]
        total_amount        <- map["total_amount"]
        created_at          <- map["created_at"]
        payment_sp          <- map["payment_sp"]
        payment_sp_text     <- map["payment_sp_text"]
        status              <- map["status"]
        
        info = YQJRechargeInfo()
        info.type = .recharge
        info.number = uuid
        info.content = content
        info.payment = payment_sp_text
        info.money = String(format: "%.2f", actual_amount.cgFloat / 100.0)
    }
}

struct YQJSubConsumeRecord: Mappable {
    var product_name: String = ""
    var catalog_name: String = ""
    var pay_method: Int = 0
    var content: String = ""
    var note: String = ""
    var created_at: Int = 0
    var trade_id: String = ""
    var coins: Int = 0
    var info: YQJRechargeInfo!
    
    init?(map: Map) {}
    init() {}
    
    mutating func mapping(map: Map) {
        product_name            <- map["product_name"]
        catalog_name            <- map["catalog_name"]
        pay_method              <- map["pay_method"]
        content                 <- map["content"]
        note                    <- map["note"]
        created_at              <- map["created_at"]
        trade_id                <- map["trade_id"]
        coins                   <- map["coins"]
        
        info = YQJRechargeInfo()
        info.type = .consume
        info.content = product_name
        info.number = trade_id
        info.payment = "余额 " + String(format: "%.2f", coins.cgFloat / 100.0)
        info.money = String(format: "%.2f", coins.cgFloat / 100.0)
    }
}

struct YQJRechargeInfo {
    var type: YQJRechargeInfoType!
    var money: String = ""
    var content: String!
    var time: String!
    var number: String!
    var payment: String!
    var info_time: String!
    
    init() {}
}
