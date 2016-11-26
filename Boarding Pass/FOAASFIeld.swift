//
//  FOAASFIeld.swift
//  Boarding Pass
//
//  Created by Karen Fuentes on 11/23/16.
//  Copyright © 2016 Karen Fuentes. All rights reserved.
//

import Foundation
class FoaasField: JSONConvertible, CustomStringConvertible {
 
    let name: String
    let field: String
    
    var description: String {
        return name + field
    }
    
    init(name: String, field: String) {
        self.name = name
        self.field = field
    }
    
    convenience required init?(json: [String : AnyObject]) {
        guard let name = json["name"] as? String,
            let field = json["field"] as? String else { return nil }
        self.init(name: name, field: field)
    }
    
    func toJson() -> [String : AnyObject] {
        return [
            "name": self.name as AnyObject,
            "field": self.field as AnyObject]
    }
    
}
