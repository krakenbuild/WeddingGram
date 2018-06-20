//
//  DetailEventVC.swift
//  Wedding
//
//  Created by Alberto Josue Gonzalez Juarez on 16/05/18.
//  Copyright © 2018 Alberto Josue Gonzalez Juarez. All rights reserved.
//

import UIKit

class DetailEventVC: UIViewController {
  @IBOutlet weak var imageEvent: UIImageView!
  @IBOutlet weak var eventDescription: UILabel!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      let event = ManagerEvent.getEventData()
      
      imageEvent.sd_setImage(with: URL(string: event.eventPhoto.url), placeholderImage: UIImage(named: "dummy.jpg"))
      eventDescription.text = event.descriptionEvent
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
