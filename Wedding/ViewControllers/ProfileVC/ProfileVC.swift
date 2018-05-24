//
//  ProfileVC.swift
//  Wedding
//
//  Created by Alberto Josue Gonzalez Juarez on 23/05/18.
//  Copyright © 2018 Alberto Josue Gonzalez Juarez. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
  
  @IBOutlet weak var textfieldName: UITextField!
  
  @IBOutlet weak var segmentedInviteBy: UISegmentedControl!
  
  @IBOutlet weak var buttonImage: UIButton!
  
  @IBOutlet weak var buttonSaveChanges: UIButton!
  
  @IBOutlet weak var buttonContinue: UIButton!
  
  @IBOutlet weak var stackButtons: UIStackView!
  
  @IBOutlet weak var constraintButtons: NSLayoutConstraint!
  let defaultValueConstraint = 157.5
  
  override func viewDidLoad() {
    super.viewDidLoad()
    constraintButtons.constant = 0
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
