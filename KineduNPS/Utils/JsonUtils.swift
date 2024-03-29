//
//  JsonUtils.swift
//  KineduNPS
//
//  Created by Hector Climaco on 21/07/23.
//  Copyright © 2023 Hector. All rights reserved.
//

import Foundation

public class JsonUtils {
    
    public class func dataToJSON(with dataInput: Data) -> [String:Any]? {
        
        do {
            if let jsonArray = try JSONSerialization.jsonObject(with: dataInput, options: .allowFragments) as? [String:Any] {
                return jsonArray // use the json here
            }
            
        } catch let error as NSError {
            debugPrint("Fail JSONSerialization: ", error)
            return nil
        }
        return nil
    }
    
    
    public class func JSONToData(JSON: [String:Any]) -> Data? {
        let jsonData = try? JSONSerialization.data(withJSONObject:JSON)
        return jsonData
    }
}
