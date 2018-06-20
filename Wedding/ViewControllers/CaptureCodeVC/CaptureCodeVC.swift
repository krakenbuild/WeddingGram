//
//  CaptureCodeVC.swift
//  Wedding
//
//  Created by Alberto Josue Gonzalez Juarez on 16/05/18.
//  Copyright © 2018 Alberto Josue Gonzalez Juarez. All rights reserved.
//

import UIKit

class CaptureCodeVC: UIViewController {
  var events = [EventModel]()
  var codeEvent = ""
  override func viewDidLoad() {
    super.viewDidLoad()
    NotificationCenter.default.addObserver(self, selector: #selector(showEvent), name: NSNotification.Name(rawValue: "showEvent"), object: nil)
    // Do any additional setup after loading the view.
  }
  @objc func showEvent() {
    codeEvent = UserDefaults.standard.value(forKey: "codeEvent") as! String
    getEvents()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  func getEvents() {
    ManagerRequest.getEvents("https://parseapi.back4app.com/classes/Events", completion:  { (result: Bool , _ response: EventResponseModel?) in
    if let response = response , result {
      DispatchQueue.main.async {
        self.events = response.data
        for obj in self.events {
          if obj.eventNumber == self.codeEvent {
            let event = EventModel()
            event.urlRequest = obj.urlRequest
            event.applicationID = obj.applicationID
            event.restAPIKey = obj.restAPIKey
            event.eventNumber = obj.eventNumber
            event.eventName = obj.eventName
            event.eventPhoto = obj.eventPhoto
            event.descriptionEvent = obj.descriptionEvent
            ManagerEvent.saveDataForEvent(event: event)
            self.performSegue(withIdentifier: "DetailEventVC", sender: nil)
          }
        }
      }
    }
  })
}
/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */

}
