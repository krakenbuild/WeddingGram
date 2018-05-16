//
//  CaptureCodeVC.swift
//  Wedding
//
//  Created by Alberto Josue Gonzalez Juarez on 16/05/18.
//  Copyright © 2018 Alberto Josue Gonzalez Juarez. All rights reserved.
//

import UIKit

class CaptureCodeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      NotificationCenter.default.addObserver(self, selector: #selector(showEvent), name: NSNotification.Name(rawValue: "showEvent"), object: nil)
        // Do any additional setup after loading the view.
    }
  @objc func showEvent() {
    performSegue(withIdentifier: "DetailEventVC", sender: nil)
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
