//
//  Response+ObjectMapper.swift
//  Alamofire
//
//  Created by jesse on 2017/10/23.
//

import Foundation
import ObjectMapper
import Moya

extension Response {
    public func mapObject<T: BaseMappable>(_ type: T.Type, keyPath: String? = nil, context: MapContext? = nil) throws -> T {
        let json: Any
        do {
            if let keyPath = keyPath {
                json = (try mapJSON() as AnyObject).value(forKeyPath: keyPath) as Any
            }else {
                json = try mapJSON()
            }
        } catch {
            throw MoyaError.jsonMapping(self)
        }

        guard let object = Mapper<T>(context: context).map(JSONObject: json) else {
            throw MoyaError.jsonMapping(self)
        }
        return object
    }

    public func mapArray<T: BaseMappable>(_ type: T.Type, keyPath: String? = nil, context: MapContext? = nil) throws -> [T] {
        let jsonArray: Any
        do {
            if let keyPath = keyPath {
                jsonArray = (try mapJSON() as AnyObject).value(forKeyPath: keyPath) as Any
            }else {
                jsonArray = try mapJSON()
            }
        } catch  {
            throw MoyaError.jsonMapping(self)
        }

        guard let array = jsonArray as? [[String : Any]] else {
            throw MoyaError.jsonMapping(self)
        }
        return Mapper<T>(context: context).mapArray(JSONArray: array)
    }
}
