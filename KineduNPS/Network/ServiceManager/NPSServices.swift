//
//  NPSServices.swift
//  KineduNPS
//
//  Created by Hector Climaco on 13/09/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import Foundation

open class NPSServices {
  
  public var showLoading: (() -> ())?
  public var hideLoading: (() -> ())?
  
  
  /// Funcion para cargar datos Net Promoter Score
  /// - Parameters:
  ///   - loadFromFile: (Opcional)  default __false__ carga los datos desde el servidor en caso de que se requiera cargar desde archivo Respurces->npsData.json __true__
  ///   - completion: completionhandler con response:[NPSItem] y error:String
  ///   - response: Array con las calificaciones por version en caso de ser != nil
  ///   - error: descripcion de error en caso de ser != nil
  public func getNPS( loadFromFile:Bool = false,_ completion: @escaping (Result<[NPSItem]?,RequestError>) -> Void) {
    
    if loadFromFile {
      self.showLoading?()
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
          self.hideLoading?()
          return completion(.success(self.readLocalFile(forName: "npsData")))
      }
      return
    }
    
    self.showLoading?()
    let service = "/bi/nps"
    let request = NetworkUtils.createRequest(urlString: service, HTTPMethod: .get)
      NetworkUtils.request(urlRequest: request) { result in
          
          self.hideLoading?()
          
          switch result {
          case .success(let success):
              let npsArray = Mapper<NPSItem>().mapArray(object: success) ?? []
              return completion(.success(npsArray))
          case .failure(let failure):
              return completion(.failure(failure))
          }
          
          
      }
    
  }
  
    public func readLocalFile(forName name: String) -> [NPSItem] {
        
        do {
            if let bundlePath = Bundle.main.path(forResource: name,ofType: "json") {
                let data = try Data(contentsOf: URL(fileURLWithPath: bundlePath), options: .alwaysMapped)
                
                
                let resonse = Mapper<NPSItem>().mapArray(object: data) ?? []
                return resonse
            }
            
        } catch {
            print(error)
        }
        
        return []
    }
  
}
