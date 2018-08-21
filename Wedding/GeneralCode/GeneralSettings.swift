//
//  ViewController.swift
//  Wedding
//
//  Created by Personal on 22/10/17.
//  Copyright © 2017 Alberto Josue Gonzalez Juarez. All rights reserved.
//

import Foundation
import UIKit

class GeneralTabBarVC: UITabBarController  {
    
    override func viewDidLoad() {
      super.viewDidLoad()
      setupTabBar()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  func setupTabBar() {
    let nameItems: NSArray = ["Momentos", "Foto","Ubicacion", "Regalos ","Perfil"]
//    let iconItems: NSArray = [#imageLiteral(resourceName: "modicon"), #imageLiteral(resourceName: "atomicon"), #imageLiteral(resourceName: "atomicon"),#imageLiteral(resourceName: "more")]
    var count = 0
    for obj in self.viewControllers! {
      obj.tabBarItem.title = nameItems.object(at: count) as? String
//      obj.tabBarItem.image = iconItems.object(at: count) as? UIImage
      count += 1
    }
  }
}

class GeneralNavigation: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    styleShopNavBar()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  func styleShopNavBar() {
    let newbar = UINavigationBar.appearance()

//    self.navigationBar.isHidden = true
//    let newbar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 64.0))
    newbar.barTintColor = UIColor.white
    newbar.isTranslucent = true
    
    let shopButton = UIBarButtonItem(image: #imageLiteral(resourceName: "more"), landscapeImagePhone: #imageLiteral(resourceName: "shopIcon"), style: UIBarButtonItemStyle.plain, target: self, action: nil)
    self.navigationItem.rightBarButtonItem = shopButton
  }
}
