//
//  GiftsTableViewController.swift
//  Wedding
//
//  Created by Personal on 22/10/17.
//  Copyright © 2017 Alberto Josue Gonzalez Juarez. All rights reserved.
//

import UIKit
import WebKit
class GiftsTableViewController: UIViewController {
    
    @IBOutlet weak var giftWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        giftWebView.load(URLRequest(url: URL(string: "https://www.liverpool.com.mx/tienda/giftregistry/giftRegistryDetail.jsp?eventNo=1&eventDNo=42363103&_requestid=902669#")!))
        // Do any additional setup after loading the view.
    }

    @IBAction func giftsSelection(_ sender: Any) {
        let place = sender as? UISegmentedControl
        if place?.selectedSegmentIndex == 0{
            giftWebView.load(URLRequest(url: URL(string: "https://www.liverpool.com.mx/tienda/giftregistry/giftRegistryDetail.jsp?eventNo=1&eventDNo=42363103&_requestid=902669#")!))

        }else{
            giftWebView.load(URLRequest(url: URL(string: "https://www.sears.com.mx/mesaregalos/productos/?id=12501830")!))
            giftWebView.reload()

        }
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
