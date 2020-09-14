//
//  NetworkUtils.swift
//  a4SysCore_iOS
//
//  Created by david on 10/10/19.
//  Copyright © 2019 Yopter. All rights reserved.


import Alamofire
import ObjectMapper

private class NetworkManager {
  /**
   Funcion static que para el consumo de peticciones
   */
  static let sessionManager: Alamofire.SessionManager = {
    let serverTrustPolicies: [String: ServerTrustPolicy] = [
      KineduConstants.server: .disableEvaluation
    ]
    
    let configuration = URLSessionConfiguration.default
    configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
    return Alamofire.SessionManager(
      configuration: configuration,
      serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
    )
  }()
}
/**
 
 */
public class NetworkUtils {
  
  private static let timeOutInterval: Double = 60
  /**
   Ejecuta URLRequest y retorna un completion con dataresponse, error
   
   - Parameters:
     - urlRequest: URLRequest con la peticion
     - completion: CompletionHandler que se ejecuta al finalizar la peticion
     - dataresponse:(Opcional) En caso de que la peticion sea exitosa regresa [String:Any]
     - error:(Opcional) En caso de que la peticion falle regresa descripcion
   */
  public static func request(urlRequest: URLRequest?,_ completion : @escaping (_ dataresponse: Any?, _ error: String?) ->(Void)){
    let sessionManager = NetworkManager.sessionManager
    
    guard let request = urlRequest else {
      return completion(nil,"URL_NOTFOUND".localized() )
    }
    
    let dataRequest:DataRequest = sessionManager.request(request)
    
    print("Begin Request...")
    dataRequest.responseJSON { (response) in
      let statusCode = response.response?.statusCode ?? 0
      #if DEBUG
      print("End Request with code: ", statusCode)
      #endif
      switch(response.result){
        
        case .success(let value):
          #if DEBUG
          print("Request Success: ",value)
          #endif
          if let jsonValueResponse =  response.result.value as? [String : Any] {
            #if DEBUG
            print("Response:",jsonValueResponse)
            #endif
            return completion(jsonValueResponse,nil)
            
          }
          return completion(value,nil)
        case .failure(let value):
          if statusCode != 200 {
            return completion(nil,value.localizedDescription)
          } else {
            return completion(nil,nil)
        }
      }
    }
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
