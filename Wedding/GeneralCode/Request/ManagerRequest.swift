//
//  ManagerRequest.swift
//  Wedding
//
//  Created by Alberto Josue Gonzalez Juarez on 18/05/18.
//  Copyright © 2018 Alberto Josue Gonzalez Juarez. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

// Mark: - ManagerRequest
class ManagerRequest {
  //get Moments
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
  static func getMoments(_ productType: String, completion: @escaping (_ result: Bool, _ statusResponse: BaseResponseModel?) -> Void) {
    
    Alamofire.request(createRequest(urlString: productType)).responseJSON { response in
      if response.result.isSuccess {
        if let resp = Mapper<BaseResponseModel>().map(JSON: response.result.value as! [String : Any]) {
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
  // get Other events
  static func createRequestEvents(urlString: String) -> URLRequest {
    var mutableURLRequest = URLRequest(url: URL(string: urlString)!)
    mutableURLRequest.httpMethod = "GET"
    
    let headers = [
      "X-Parse-Application-Id": "tNcfRLBapCAEdeYN0OiGztJobgr8vdmat4VwWf5i",
      "X-Parse-REST-API-Key": "LeggJCRqQIwcdagVzR6f4vxBG6PpiQk8T1IMbOcE",
      ]
    mutableURLRequest.allHTTPHeaderFields = headers
    
    return mutableURLRequest
  }
  static func getEvents(_ productType: String, completion: @escaping (_ result: Bool, _ statusResponse: EventResponseModel?) -> Void) {
    
    Alamofire.request(createRequestEvents(urlString: productType)).responseJSON { response in
      if response.result.isSuccess {
        if let resp = Mapper<EventResponseModel>().map(JSON: response.result.value as! [String : Any]) {
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
// Mark: - BaseResponseModel get Moments
class BaseResponseModel: Mappable {
  
  var data = [MomentModel]()
  
  init(){}
  
  required init?(map: Map){
  }
  
  func mapping(map: Map) {
    data <- map["results"]
  }
}

class MomentModel: Mappable, NSCoding{
  
  var descriptionMoment = ""
  var photoMoment = PhotoModel()
  var nameFriend = ""
  var photoFriend = PhotoModel()
  var objectId = ""
  
  init(){}
  
  func encode(with aCoder: NSCoder) {
  }
  required init?(coder aDecoder: NSCoder) {
  }
  required init?(map: Map){
  }
  
  func mapping(map: Map) {
    descriptionMoment <- map["descriptionMoment"]
    photoMoment <- map["photoMoment"]
    nameFriend <- map["nameFriend"]
    photoFriend <- map["photoFriend"]
    objectId <- map["objectId"]
  }
}
class PhotoModel:  Mappable {
  var type = ""
  var name = ""
  var url = ""
  
  init(){}
  
  func encode(with aCoder: NSCoder) {
  }
  required init?(coder aDecoder: NSCoder) {
  }
  required init?(map: Map){
  }
  
  func mapping(map: Map) {
    type <- map["__type"]
    name <- map["name"]
    url <- map["url"]
  }
}

/// get events
class EventResponseModel: Mappable {
  
  var data = [EventModel]()
  
  init(){}
  
  required init?(map: Map){
  }
  
  func mapping(map: Map) {
    data <- map["results"]
  }
}

class EventModel: Mappable {
  
  var urlRequest = ""
  var applicationID = ""
  var restAPIKey = ""
  var eventName = ""
  var eventNumber = ""
  var eventPhoto = PhotoModel()
  var descriptionEvent = ""

  
  init(){}
  
  func encode(with aCoder: NSCoder) {
  }
  required init?(coder aDecoder: NSCoder) {
  }
  required init?(map: Map){
  }
  
  func mapping(map: Map) {
    urlRequest <- map["urlRequest"]
    applicationID <- map["applicationID"]
    restAPIKey <- map["restAPIKey"]
    eventName <- map["eventName"]
    eventNumber <- map["objectId"]
    eventPhoto <- map["eventPhoto"]
    descriptionEvent <- map["descriptionEvent"]
  }
}


