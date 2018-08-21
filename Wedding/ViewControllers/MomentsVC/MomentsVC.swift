//
//  MomentsVC.swift
//  Wedding
//
//  Created by Personal on 22/10/17.
//  Copyright © 2017 Alberto Josue Gonzalez Juarez. All rights reserved.
//

import UIKit
import SDWebImage

class MomentsVC: BaseViewController {
  @IBOutlet weak var momentsTableView: UITableView!
  @IBOutlet weak var contrainHeader: NSLayoutConstraint!
  @IBOutlet weak var viewHeader: UIView!
  @IBOutlet weak var buttonInfo: UIButton!
  @IBOutlet weak var buttonScan: UIButton!
  
  var moments = [MomentModel]()
  override func viewDidLoad() {
    super.viewDidLoad()
    setView()
    getMoments()

  }
  override func viewDidAppear(_ animated: Bool) {
    let eventNumber = UserDefaults.standard.value(forKey: "event") as? String ?? "0000"
    if !(eventNumber == "0000") {
      contrainHeader.constant = -viewHeader.bounds.height
    }
    getMoments()
  }
  func setView() {
    self.momentsTableView.delegate = self
    self.momentsTableView.dataSource = self
    
    viewHeader.layer.shadowColor = UIColor.black.cgColor
    viewHeader.layer.shadowOffset = CGSize(width: 4, height: 4)
    viewHeader.layer.shadowRadius =  3.0
    viewHeader.backgroundColor = .white
    viewHeader.layer.shadowOpacity = 1.0
    viewHeader.layer.masksToBounds = false
    
    buttonInfo.setTitle("Información", for: .normal)
    buttonInfo.setTitleColor(UIColor.black, for: .normal)
    
    buttonScan.setTitle("Scanea un codigo", for: .normal)
    buttonScan.setTitleColor(UIColor.black, for: .normal)
    buttonScan.titleLabel?.numberOfLines = 0
    
    showTutorial()
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    // Hide the navigation bar on the this view controller
    self.navigationController?.setNavigationBarHidden(false, animated: animated)
  }

  func showTutorial() {
    let userDF = UserDefaults.standard
    let isTutorial = userDF.value(forKey: "isTutorial") as? Int ?? 0
    if isTutorial == 0 {
      let vc = self.storyboard?.instantiateViewController(withIdentifier: "TutorialVC") as! TutorialVC
      self.present(vc, animated: true, completion: nil)
    }
  }
  
  func getMoments() {
    ManagerRequest.getMoments("https://parseapi.back4app.com/classes/Moments", completion:  { (result: Bool , _ response: BaseResponseModel?) in
      
      if let response = response , result {
        DispatchQueue.main.async {
          self.moments = response.data
          self.momentsTableView.reloadData()
        }
      }
    })
  }
  // MARK: - Parse
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

extension MomentsVC: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return tableView.frame.height
  }
}

extension MomentsVC: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return moments.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! MomentsTableViewCell
    let moment = moments[indexPath.row]
    cell.imageMoment.sd_setImage(with: URL(string: moments[indexPath.row].photoMoment.url), placeholderImage: UIImage(named: "dummy.jpg"))
    cell.imageFriend.sd_setImage(with: URL(string: moments[indexPath.row].photoFriend.url), placeholderImage: UIImage(named: "dummy.jpg"))
    cell.labelByMe.text = moment.nameFriend
    cell.labelMoment.text = moment.descriptionMoment
    return cell
  }
}
extension MomentsVC: UIScrollViewDelegate {
    
}
