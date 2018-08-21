//
//  CameraVC.swift
//  Wedding
//
//  Created by Alberto Josue Gonzalez Juarez on 25/04/18.
//  Copyright © 2018 Alberto Josue Gonzalez Juarez. All rights reserved.
//

import UIKit
import iOSPhotoEditor

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
  var file: BEFile?
  let backendless = Backendless.sharedInstance()!
  var mainImage: UIImage?
  //backendless

  override func viewDidLoad() {
    super.viewDidLoad()
    setUI()
    showCamera()
    addNotifications()
    // Do any additional setup after loading the view.
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    // Hide the navigation bar on the this view controller
    self.navigationController?.setNavigationBarHidden(false, animated: animated)
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
    let uploadFile = backendless.file.saveFile(String(format: "img/%0.0f.jpeg", Date().timeIntervalSince1970), content: UIImageJPEGRepresentation(mainImage!, 0.1))
    self.saveEntityWithName(path: uploadFile?.fileURL)
  }
  
  // MARK: - backendless

  func saveEntityWithName(path: String?) {
    self.file = BEFile()
    self.file?.PhotoMoment = path
    self.file?.PhotoMoment = path
    self.file?.DescriptionMoment = textViewMoment.text
    self.file?.NameFriend = labelByMe.text
    
    backendless.data.save(self.file,
                          response: {
                            (response: Any?) -> () in
                            let alert = UIAlertController(title: "Felicidades", message: "Tu Foto se publico exitosamente", preferredStyle: .alert)
                            let ok = UIAlertAction(title: "ok", style: .default, handler: nil)
                            alert.addAction(ok)
                            self.present(alert, animated: true, completion: nil)
    },
                          error: {
                            (fault: Fault?) -> () in
                            let alert = UIAlertController(title: "Error", message: fault?.message, preferredStyle: .alert)
                            let ok = UIAlertAction(title: "ok", style: .default, handler: nil)
                            alert.addAction(ok)
                            self.present(alert, animated: true, completion: nil)
    })
  }
  // MARK: - backendless

  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
extension CameraVC: PhotoEditorDelegate {
  
  func doneEditing(image: UIImage) {
   
    self.imageMoment.image = image

  }
  
  func canceledEditing() {
    print("Canceled")
  }
}
extension CameraVC: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    imageMoment.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    mainImage = info[UIImagePickerControllerOriginalImage] as? UIImage
    guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
      picker.dismiss(animated: true, completion: nil)
      return
    }
    
    let photoEditor = PhotoEditorViewController(nibName:"PhotoEditorViewController",bundle: Bundle(for: PhotoEditorViewController.self))
    photoEditor.photoEditorDelegate = self
    photoEditor.image = image
    //Colors for drawing and Text, If not set default values will be used
    //photoEditor.colors = [.red, .blue, .green]
    
    //Stickers that the user will choose from to add on the image
    for i in 0...32 {
      photoEditor.stickers.append(UIImage(named: i.description )!)
    }
    
    //To hide controls - array of enum control
    //photoEditor.hiddenControls = [.crop, .draw, .share]
    
//    present(photoEditor, animated: true, completion: nil)
//    picker.dismiss(animated: false, completion: nil)
    picker.dismiss(animated: false) {
      self.present(photoEditor, animated: false, completion: nil)

    }
  
   
//    imagePicker.dismiss(animated: true, completion: nil)
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true, completion: nil)
  }
}


