//
//  FOAAS.swift
//  Boarding Pass
//
//  Created by Karen Fuentes on 11/23/16.
//  Copyright © 2016 Karen Fuentes. All rights reserved.
//

import Foundation

class Foaas: CustomStringConvertible {
    
    let message: String
    let subtitle: String
    var description: String {
        return message + subtitle
    }
    
    init(message: String, subtitle: String) {
        self.message = message
        self.subtitle = subtitle
    }
    
    convenience required init?(json: [String : AnyObject]) {
        guard let message: String = json["message"] as? String,
            let subtitle: String = json["subtitle"] as? String else{ return nil }
        self.init(message: message, subtitle: subtitle)
    }
    
    
}
