//
//  RequestConfiguratios.swift
//  Wedding
//
//  Created by Alberto Josue Gonzalez Juarez on 14/06/18.
//  Copyright © 2018 Alberto Josue Gonzalez Juarez. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class RequestConfiguratios {
  static func createRequest(urlString: String) -> URLRequest {
    var mutableURLRequest = URLRequest(url: URL(string: urlString)!)
    mutableURLRequest.httpMethod = "GET"
    let event = ManagerEvent.getEventData()
    let headers = [
      "X-Parse-Application-Id": event.applicationID,
      "X-Parse-REST-API-Key": event.restAPIKey,
      ]
    mutableURLRequest.allHTTPHeaderFields = headers
    
    return mutableURLRequest
  }
  static func getConfiguratios(_ productType: String, completion: @escaping (_ result: Bool, _ statusResponse: ResponseModelConfiguratios?) -> Void) {
    
    Alamofire.request(createRequest(urlString: productType)).responseJSON { response in
      if response.result.isSuccess {
        if let resp = Mapper<ResponseModelConfiguratios>().map(JSON: response.result.value as! [String : Any]) {
          completion(true,resp)
        }
        else {
          completion(false,nil)
        }
      }
      else {
        completion(false,nil)
      }
    }
  }
}
class ResponseModelConfiguratios: Mappable {
  
  var data = [ConfigurationModel]()
  
  init(){}
  
  required init?(map: Map){
  }
  
  func mapping(map: Map) {
    data <- map["results"]
  }
}
class ConfigurationModel: Mappable, NSCoding{
  
  var nameEvent = ""
  var descriptionEvent = ""
  var imageEvent = PhotoModel()
  
  init(){}
  
  func encode(with aCoder: NSCoder) {
  }
  required init?(coder aDecoder: NSCoder) {
  }
  required init?(map: Map){
  }
  
  func mapping(map: Map) {
    nameEvent <- map["nameEvent"]
    descriptionEvent <- map["descriptionEvent"]
    imageEvent <- map["nameFriend"]
  }
}
