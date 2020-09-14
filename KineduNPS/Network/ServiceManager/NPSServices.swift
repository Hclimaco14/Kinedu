//
//  NPSServices.swift
//  KineduNPS
//
//  Created by Hector Climaco on 13/09/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import Foundation
import ObjectMapper

open class NPSServices {
  
  public var showLoading: (() -> ())?
  public var hideLoading: (() -> ())?
  
  
  /// Funcion para cargar datos Net Promoter Score
  /// - Parameters:
  ///   - loadFromFile: (Opcional)  default __false__ carga los datos desde el servidor en caso de que se requiera cargar desde archivo Respurces->npsData.json __true__
  ///   - completion: completionhandler con response:[NPSItem] y error:String
  ///   - response: Array con las calificaciones por version en caso de ser != nil
  ///   - error: descripcion de error en caso de ser != nil
  public func getNPS( loadFromFile:Bool = false,_ completion: @escaping (_ response: [NPSItem]?,_ error:String?) -> Void) {
    
    if loadFromFile {
      self.showLoading?()
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        completion(self.readLocalFile(forName: "npsData"),nil)
        self.hideLoading?()
      }
      return
    }
    
    self.showLoading?()
    let service = "/bi/nps"
    let request = NetworkUtils.createRequest(urlString: service, HTTPMethod: .get)
    NetworkUtils.request(urlRequest: request) { (response, errorDesciption) in
      
      self.hideLoading?()
      
      if let error = errorDesciption {
        return completion(nil,error)
      } else {
        let npsArray = Mapper<NPSItem>().mapArray(JSONObject: response) ?? []
        completion(npsArray, nil)
      }
    }
    
  }
  
  public func readLocalFile(forName name: String) -> [NPSItem]? {
      
      do {
        if let bundlePath = Bundle.main.path(forResource: name,ofType: "json") {
              let data = try Data(contentsOf: URL(fileURLWithPath: bundlePath), options: .mappedIfSafe)
        
              let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
              print(jsonResult)
              let resonse = Mapper<NPSItem>().mapArray(JSONObject: jsonResult) ?? []
              return resonse
          }
          
      } catch {
          print(error)
      }
      
      return nil
  }
  
}
