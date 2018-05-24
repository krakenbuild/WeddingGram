//
//  ManagerRequest.swift
//  Wedding
//
//  Created by Alberto Josue Gonzalez Juarez on 18/05/18.
//  Copyright © 2018 Alberto Josue Gonzalez Juarez. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import ObjectMapper

// Mark: - ManagerRequest
class ManagerRequest {
  static func createRequest(urlString: String) -> URLRequest {
    var mutableURLRequest = URLRequest(url: URL(string: urlString)!)
    mutableURLRequest.httpMethod = "GET"
//    let headers = [
//      "Content-Type": "B9E252F4-E904-F364-FFA4-ABE508611200",
//      "secret-key": "9C478874-7423-AA42-FF36-E597BA8F4E00",
//      ]
    return mutableURLRequest
  }
  static func getMoments(_ productType: String, completion: @escaping (_ result: Bool, _ statusResponse: BaseResponseModelMoments?) -> Void) {
    
    Alamofire.request(createRequest(urlString: productType)).responseJSON { response in
      if response.result.isSuccess {
        if let resp = Mapper<BaseResponseModelMoments>().map(JSON: response.result.value as! [String : Any]) {
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

// Mark: - BaseResponseModel
class BaseResponseModel: Mappable {
  
  var offset = ""
  var data = [MomentModel]()
  var nextPage = ""
  var totalObjects = ""
  
  init(){}
  
  required init?(map: Map){
  }
  
  func mapping(map: Map) {
    offset <- map["offset"]
    data <- map["data"]
    nextPage <- map["nextPage"]
    totalObjects <- map["totalObjects"]
  }
}

// Mark: - productModel - MomentModel
class MomentModel: Mappable, NSCoding{
  
  var description = ""
  var mainPhoto = ""
  var nameFriend = ""
  var photoFriend = ""
  var created = ""
  var ownerId = ""
  var updated = ""
  var objectId = ""
  
  init(){}
  
  func encode(with aCoder: NSCoder) {
  }
  required init?(coder aDecoder: NSCoder) {
  }
  required init?(map: Map){
  }
  
  func mapping(map: Map) {
    description <- map["description"]
    mainPhoto <- map["mainPhoto"]
    nameFriend <- map["nameFriend"]
    photoFriend <- map["photoFriend"]
    created <- map["created"]
    ownerId <- map["ownerId"]
    updated <- map["updated"]
    objectId <- map["objectId"]
  }
}

// Mark: - BaseResponseModelMoments
class BaseResponseModelMoments: Mappable {
  
  var offset = ""
  var data = [MomentModel]()
  var nextPage = ""
  var totalObjects = ""
  
  init(){}
  
  required init?(map: Map){
  }
  
  func mapping(map: Map) {
    offset <- map["offset"]
    data <- map["data"]
    nextPage <- map["nextPage"]
    totalObjects <- map["totalObjects"]
  }
}

