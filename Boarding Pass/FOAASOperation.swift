//
//  FOAASOperation.swift
//  Boarding Pass
//
//  Created by Karen Fuentes on 11/23/16.
//  Copyright © 2016 Karen Fuentes. All rights reserved.
//

import Foundation
class FoaasOperation {
  
    let name: String
    let url: String
    let fields: [FoaasField]
    
    init(name: String, url: String, fields: [FoaasField]) {
        self.name = name
        self.url = url
        self.fields = fields
    }
    
    convenience required init?(json: [String : AnyObject]) {
        guard let name: String = json["name"] as? String,
            let url: String = json["url"] as? String,
            let fields: [[String: AnyObject]] = json["fields"] as? [[String: AnyObject]] else { return nil }
        
        var allFields: [FoaasField] = []
        
        for element in fields{
            if let foaas = FoaasField(json: element){
                allFields.append(foaas)
            }
        }
        self.init(name: name, url: url, fields: allFields)
    }
    
    convenience required init?(data: Data) {
        do {
            let rawData: AnyObject = try JSONSerialization.jsonObject(with: data, options: []) as AnyObject
            
            guard let json: [String: AnyObject] = rawData as? [String: AnyObject] else { return nil }
            
            self.init(json: json)
        } catch {
            print("Error initialization parsing data in FoaasOperation: \(error)")
        }
        return nil
    }
}
