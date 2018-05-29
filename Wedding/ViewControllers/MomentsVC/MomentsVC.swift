//
//  MomentsVC.swift
//  Wedding
//
//  Created by Personal on 22/10/17.
//  Copyright © 2017 Alberto Josue Gonzalez Juarez. All rights reserved.
//

import UIKit

class MomentsVC: UIViewController {
  @IBOutlet weak var momentsTableView: UITableView!
  @IBOutlet weak var contrainHeader: NSLayoutConstraint!
  @IBOutlet weak var viewHeader: UIView!
  @IBOutlet weak var buttonInfo: UIButton!
  @IBOutlet weak var buttonScan: UIButton!
  
  var moments = [MomentModel]()
  override func viewDidLoad() {
    super.viewDidLoad()
    setUI()
    getmomentsBackendless()
//    getMoments()

  }
  func setUI() {
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
    if false {
      contrainHeader.constant = -viewHeader.bounds.height
    }
  }
  
  func getmomentsBackendless() {
    let backendless = Backendless.sharedInstance()!
    backendless.data.find(BEFile.ofClass(),
                                           queryBuilder: DataQueryBuilder(),
                                           response: {
                                            (retrievedData: [Any]?) -> () in
                                            let arr = [Any]()
                                            
                                            
                                            
                                            print("josue")
                                            print(retrievedData ?? "josue2")
    },
                                           error: {
                                            (fault: Fault?) -> () in
                                          
    })

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
    ManagerRequest.getMoments("https://api.backendless.com/B9E252F4-E904-F364-FFA4-ABE508611200/4250F7B7-FD48-41CA-FFFE-6373F6651500/data/BEFile", completion:  { (result: Bool , _ response: BaseResponseModelMoments?) in
      if let response = response , result {
        self.moments = response.data
        self.momentsTableView.reloadData()
      }
    })
}
  override func viewWillAppear(_ animated: Bool) {
  }
  override func viewDidAppear(_ animated: Bool) {
    
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

extension MomentsVC: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return tableView.frame.height
  }
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let view = UIView()
    view.backgroundColor = .red
    return view
  }
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 0
  }
}

extension MomentsVC: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return moments.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! MomentsTableViewCell
    cell.imageMoment.image = UIImage.init(named: "dummy.jpg")
    //        cell.labelMoment.text = "Happy Wedding"
    return cell
  }
}

