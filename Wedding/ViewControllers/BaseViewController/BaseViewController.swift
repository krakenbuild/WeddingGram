//
//  BaseViewController.swift
//  Wedding
//
//  Created by Alberto Josue Gonzalez Juarez on 12/06/18.
//  Copyright © 2018 Alberto Josue Gonzalez Juarez. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      setUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  func setUI() {
    let userDF = UserDefaults.standard
    let isWedding = userDF.value(forKey: "isFirst") as? Int ?? 0
    if isWedding == 0 {
      userDF.set(1, forKey: "isFirst")
      ManagerEvent.removeEvent()
    }
    let event = ManagerEvent.getEventData()
//    self.title = event.eventName
    self.navigationController?.title = event.eventName
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
