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
  override func viewDidLoad() {
        super.viewDidLoad()
        self.momentsTableView.delegate = self
        self.momentsTableView.dataSource = self
        showTutorial()
    if false {
      contrainHeader.constant = -viewHeader.bounds.height
    }
        // Do any additional setup after loading the view.
    }
  func showTutorial() {
    let userDF = UserDefaults.standard
    let isTutorial = userDF.value(forKey: "isTutorial") as? Int ?? 0
    if isTutorial == 0 {
      let vc = self.storyboard?.instantiateViewController(withIdentifier: "TutorialVC") as! TutorialVC
      self.present(vc, animated: true, completion: nil)
    }
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! MomentsTableViewCell
        cell.imageMoment.image = UIImage.init(named: "dummy.jpg")
//        cell.labelMoment.text = "Happy Wedding"
        return cell
    }
}

