//
//  DataManager(FOAAS).swift
//  Boarding Pass
//
//  Created by Karen Fuentes on 11/26/16.
//  Copyright © 2016 Karen Fuentes. All rights reserved.
//

import Foundation

class DataManager {

    static let shared: DataManager = DataManager()
    private init() {}
    
    private static let operationsKey: String = "FoaasOperationsKey"
    private static let defaults = UserDefaults.standard
    internal private(set) var operations: [FoaasOperation]?
    
   
    func save(operations: [FoaasOperation]) {
        let data = operations.flatMap{FoaasOperation.toData($0)}
       //still missing defaults
    }
    
    func load() -> Bool {
        guard let data = DataManager.defaults.value(forKey: DataManager.operationsKey) as? [Data] else { return false }
        let operationsArray = data.flatMap{ FoaasOperation(data: $0) }
        DataManager.shared.operations = operationsArray
        return true
    }
    
    func deleteStoredOperations() {
        DataManager.defaults.set(nil, forKey: DataManager.operationsKey)
    }
}




