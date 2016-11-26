//
//  APIManager(FOAAS).swift
//  Boarding Pass
//
//  Created by Karen Fuentes on 11/23/16.
//  Copyright © 2016 Karen Fuentes. All rights reserved.
//

import Foundation

class FoaasAPIManager {
    private static let defaultSession = URLSession(configuration: .default)
    
    internal class func getFoaas(url: URL, completion: @escaping (Foaas?)->Void){
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        defaultSession.dataTask(with: request){ (data: Data?, _, someError: Error?) in
            if someError != nil{
                print("Error with foaas url request \(someError!)")
            }
            
            if data != nil{
                do{
                    
                    let rawData = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject]
                    
                    if let json = rawData{
                        completion(Foaas(json: json))
                    }
                    
                    return
                }catch{
                    print("Error serializing foaas data: \(error)")
                }
            }
        }.resume()
    }
    
    internal class func getOperations(completion: @escaping ([FoaasOperation]?)->Void) {
        var request: URLRequest = URLRequest(url: URL(string: "http://www.foaas.com/operations")!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        defaultSession.dataTask(with: request){(data: Data?, _ , error: Error?) in
            if error != nil {
                print("Error with [foassOperation] url request [foassOperation] \(error)")
            }
            if data != nil {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [[String:AnyObject]]
                    var arrayofFoaasOpertions = [FoaasOperation]()
                    for operation in json! {
                        arrayofFoaasOpertions.append(FoaasOperation(json: operation)!)
                    }
                    completion(arrayofFoaasOpertions)
                }
                catch {
                    print("error in converting operation data \(error)")
                }
                
            }
            
        }.resume()
    }
}
