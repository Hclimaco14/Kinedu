//
//  NetworkUtils.swift
//  a4SysCore_iOS
//
//  Created by david on 10/10/19.
//  Copyright © 2019 Yopter. All rights reserved.

import Foundation
/**
 
 */

public enum HTTPMethod:String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}

public struct RequestError: Error {
    let description: String
}

public class NetworkUtils {
    
    private static let session = URLSession.shared
  
    private static let timeOutInterval: Double = 60
  /**
   Ejecuta URLRequest y retorna un completion con dataresponse, error
   
   - Parameters:
     - urlRequest: URLRequest con la peticion
     - completion: CompletionHandler que se ejecuta al finalizar la peticion
     - dataresponse:(Opcional) En caso de que la peticion sea exitosa regresa [String:Any]
     - error:(Opcional) En caso de que la peticion falle regresa descripcion
   */
 public static func request(urlRequest: URLRequest?,_ completion : @escaping (Result<Any?, RequestError>) -> Void) {
    
    guard let request = urlRequest else {
        return completion(.failure(RequestError(description: "URL_NOTFOUND".localized())))
    }
    
     self.session.dataTask(with: request, completionHandler: { data, response, error in
         if let error = error {
             return completion(.failure(RequestError(description: error.localizedDescription)))
         }
         guard let response = response, let data = data else {
             return completion(.failure( RequestError(description: "UNKNOW_ERROR".lowercased())))
         }
         
         
         guard let httpResp = response as? HTTPURLResponse,
         (200...299).contains(httpResp.statusCode) else {
             return completion(.failure(RequestError(description: "UNKNOW_ERROR".lowercased())))
         }
         
         return completion(.success(JsonUtils.dataToJSON(with: data)))
         
     }).resume()
  }
  
  
  
  public static func createRequest(urlString: String?, HTTPMethod: HTTPMethod, body: String? =  nil) -> URLRequest?{
    
    var urlStr = KineduConstants.server
    
    if let url = urlString {
      urlStr += url
    }
    
    guard let urlConexion = URL(string: urlStr) else { return nil }
    
    var urlRequest = URLRequest(url: urlConexion)
    
    urlRequest.httpMethod = HTTPMethod.rawValue
    urlRequest.timeoutInterval = timeOutInterval
    if let dataBody = body {
      urlRequest.httpBody =  dataBody.data(using: String.Encoding.utf8)
    }
    
    return urlRequest
    
  }
  
}
