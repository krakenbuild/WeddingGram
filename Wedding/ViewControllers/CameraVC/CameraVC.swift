//
//  CameraVC.swift
//  Wedding
//
//  Created by Alberto Josue Gonzalez Juarez on 25/04/18.
//  Copyright © 2018 Alberto Josue Gonzalez Juarez. All rights reserved.
//

import UIKit

class CameraVC: UIViewController {
  @IBOutlet weak var imageMoment: UIImageView!
  
  @IBOutlet weak var textViewMoment: UITextView!
  
  @IBOutlet weak var meImage: UIImageView!
  
  @IBOutlet weak var labelByMe: UILabel!
  
  @IBOutlet weak var scrollContent: UIScrollView!
  
  @IBOutlet weak var buttonRetry: UIButton!
  
  @IBOutlet weak var buttonPost: UIButton!
  
  var imagePicker: UIImagePickerController!
  //backendless
  override func viewDidLoad() {
    super.viewDidLoad()
    setUI()
    showCamera()
    addNotifications()
    // Do any additional setup after loading the view.
  }
  func setUI() {
    
    buttonPost.setTitle("Publicar", for: .normal)
    buttonPost.setTitleColor(UIColor.black, for: .normal)
    
    buttonRetry.setTitle("Tomar de nuevo", for: .normal)
    buttonRetry.setTitleColor(UIColor.black, for: .normal)
    
  }
  func showCamera() {
    imagePicker =  UIImagePickerController()
    imagePicker.delegate = self
    imagePicker.sourceType = .camera
    present(imagePicker, animated: false, completion: nil)
  }
  func addNotifications(){
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(notification:)), name: .UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(notification:)), name: .UIKeyboardWillHide, object: nil)
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.hiddenKeyboard))
    self.view.addGestureRecognizer(tapGestureRecognizer)
  }
  @objc
  func keyboardWillAppear(notification: NSNotification?) {
    guard let keyboardFrame = notification?.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue else {
      return
    }
    var keyboardHeight: CGFloat
    if #available(iOS 11.0, *) {
      keyboardHeight = keyboardFrame.cgRectValue.height - self.view.safeAreaInsets.bottom
    } else {
      keyboardHeight = keyboardFrame.cgRectValue.height
    }
//    heightConst.constant = keyboardHeight + 15.0
    scrollContent.contentOffset = CGPoint(x: 0, y: keyboardHeight)
  }
  
  @objc
  func keyboardWillDisappear(notification: NSNotification?) {
//    heightConst.constant = 15.0
    scrollContent.contentOffset = CGPoint(x: 0, y: 0)
  }
  @objc
  func hiddenKeyboard() {
    self.view.endEditing(true)
  }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func actionTakeRetry(_ sender: Any) {
    showCamera()
  }
  @IBAction func actionPost(_ sender: Any) {
    let alert = UIAlertController(title: "Felicidades", message: "Tu Foto se publico exitosamente", preferredStyle: .alert)
    let ok = UIAlertAction(title: "ok", style: .default, handler: nil)
    alert.addAction(ok)
    present(alert, animated: true, completion: nil)
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
extension CameraVC: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    imageMoment.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    let logo =  info[UIImagePickerControllerOriginalImage] as? UIImage
    let imageData:Data =  UIImagePNGRepresentation(logo!)!
    let base64String = imageData.base64EncodedString()
    print(base64String.count)
    print(base64String)
    
    
    imagePicker.dismiss(animated: true, completion: nil)
  }
}
