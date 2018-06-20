//
//  ManagerEvent.swift
//  Wedding
//
//  Created by Alberto Josue Gonzalez Juarez on 12/06/18.
//  Copyright © 2018 Alberto Josue Gonzalez Juarez. All rights reserved.
//

import Foundation
class ManagerEvent {
  static func saveDataForEvent(event: EventModel) {
    let userDF = UserDefaults.standard
    userDF.set(event.urlRequest, forKey: "url")
    userDF.set(event.applicationID, forKey: "applicationID")
    userDF.set(event.restAPIKey, forKey: "restAPIKey")
    userDF.set(event.eventNumber, forKey: "event")
    userDF.set(event.eventName, forKey: "eventName")
    userDF.set(event.eventPhoto.url, forKey: "eventPhoto")
    userDF.set(event.descriptionEvent, forKey: "descriptionEvent")
    userDF.setValue(0, forKey: "isTutorial")
    userDF.synchronize()
  }
  
  static func getEventData() -> EventModel {
    let userDF = UserDefaults.standard
    let event = EventModel()
    event.urlRequest = userDF.value(forKey: "url") as? String ?? "https://parseapi.back4app.com/classes/Moments"
    event.applicationID = userDF.value(forKey: "applicationID") as? String ?? "tNcfRLBapCAEdeYN0OiGztJobgr8vdmat4VwWf5i"
    event.restAPIKey = userDF.value(forKey: "restAPIKey") as? String ?? "LeggJCRqQIwcdagVzR6f4vxBG6PpiQk8T1IMbOcE"
    event.eventNumber = userDF.value(forKey: "event") as? String ?? "0000"
    event.eventName = userDF.value(forKey: "eventName") as? String ?? "WeddingGram"
    event.eventPhoto.url = userDF.value(forKey: "eventPhoto") as? String ?? "String"
    event.descriptionEvent = userDF.value(forKey: "descriptionEvent") as? String ?? "String"
    return event
  }
  static func removeEvent() {
    let userDF = UserDefaults.standard
    userDF.set("https://parseapi.back4app.com/classes/Moments", forKey: "url")
    userDF.set("tNcfRLBapCAEdeYN0OiGztJobgr8vdmat4VwWf5i", forKey: "applicationID")
    userDF.set("LeggJCRqQIwcdagVzR6f4vxBG6PpiQk8T1IMbOcE", forKey: "restAPIKey")
    userDF.set("0000", forKey: "event")
    userDF.set("yep", forKey: "eventPhoto")
    userDF.set("WeddingGram", forKey: "eventName")
    userDF.set("eeee", forKey: "descriptionEvent")

    userDF.synchronize()
  }
}
