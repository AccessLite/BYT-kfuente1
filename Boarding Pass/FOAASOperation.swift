//
//  FOAASOperation.swift
//  Boarding Pass
//
//  Created by Karen Fuentes on 11/23/16.
//  Copyright © 2016 Karen Fuentes. All rights reserved.
//

import Foundation
class FoaasOperation: JSONConvertible, DataConvertible {
  
    let name: String
    let url: String
    let fields: [FoaasField]
    
    init(name: String, url: String, fields: [FoaasField]) {
        self.name = name
        self.url = url
        self.fields = fields
    }
    
    convenience required init?(json: [String : AnyObject]) {
        guard let name: String = json["name"] as? String else {return nil}
        guard let url: String = json["url"] as? String else {return nil}
        guard let fields: [[String: AnyObject]] = json["fields"] as? [[String: AnyObject]] else { return nil }
        
        var allFields: [FoaasField] = []
        
        for field in fields{
            if let foaas = FoaasField(json: field){
                allFields.append(foaas)
            }
        }
        self.init(name: name, url: url, fields: allFields)
    }
    
    convenience required init?(data: Data) {
        do {
            let data: AnyObject = try JSONSerialization.jsonObject(with: data, options: []) as AnyObject
            
            guard let json: [String: AnyObject] = data as? [String: AnyObject] else { return nil }
            
            self.init(json: json)
        } catch {
            print("Error parsing data in FoaasOperation: \(error)")
        }
        return nil
    }
    
    func toJson() -> [String : AnyObject] {
        return [
            "name": self.name as AnyObject,
            "url": self.url as AnyObject,
            //"fields": self.fields.flatMap{0.toJson()} as AnyObject
        ]
    }
    
    func toData() throws -> Data {
        return try JSONSerialization.data(withJSONObject: self.toJson(), options: [])
    }
}

    








