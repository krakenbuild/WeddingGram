//
//  ProfileDetailVC.swift
//  Wedding
//
//  Created by Alberto Josue Gonzalez Juarez on 04/07/18.
//  Copyright © 2018 Alberto Josue Gonzalez Juarez. All rights reserved.
//

import UIKit
import iOSPhotoEditor

class ProfileDetailVC: BaseViewController {
  
  @IBOutlet weak var labelName: UILabel!
  @IBOutlet weak var labelInviteFor: UILabel!
  @IBOutlet weak var labelRoll: UILabel!
  
  @IBOutlet weak var imageQREvent: UIImageView!
  @IBOutlet weak var imgProfile: UIImageView!
  
  @IBOutlet weak var viewUpdateProfile: UIView!
  @IBOutlet weak var viewProfile: UIView!
  
  @IBOutlet weak var constraintUpdateProfileAnimationY: NSLayoutConstraint!
  
  @IBOutlet weak var textFieldName: UITextField!
  @IBOutlet weak var textFieldInvite: UITextField!
  @IBOutlet weak var textFieldRoll: UITextField!
  
  @IBOutlet weak var btnEditProfileImage: UIButton!
  
  var imagePicker: UIImagePickerController!
  var image = UIImage()
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUI()
    getInformation()
    // Do any additional setup after loading the view.
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    // Hide the navigation bar on the this view controller
    self.navigationController?.setNavigationBarHidden(true, animated: animated)
  }
  
  override func setUI() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(endEditing))
    self.view.addGestureRecognizer(tapGesture)
    
    viewUpdateProfile.backgroundColor = UIColor.white
    
    viewProfile.backgroundColor = UIColor(red: 255.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1.0)
    viewProfile.layer.cornerRadius = 10
    viewProfile.layer.shadowColor = UIColor.black.cgColor
    viewProfile.layer.shadowOpacity = 1
    viewProfile.layer.shadowOffset = CGSize.zero
    viewProfile.layer.shadowRadius = 5
    
    self.imgProfile.layer.cornerRadius = self.imgProfile.frame.width / 2
    self.imgProfile.layer.borderWidth = 10
    self.imgProfile.layer.borderColor = UIColor(red: 255.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1.0).cgColor
    self.imgProfile.clipsToBounds = true
    
    self.btnEditProfileImage.layer.cornerRadius = self.imgProfile.frame.width / 2
    self.btnEditProfileImage.clipsToBounds = true
    self.btnEditProfileImage.setImage(UIImage.init(named: "editProfile"), for: .normal)
    self.btnEditProfileImage.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
    self.btnEditProfileImage.isHidden = true
    
    self.imageQREvent.image = generateQRCode(from: "HEllo")
    self.imageQREvent.contentMode = .scaleToFill
    self.imageQREvent.layer.cornerRadius = 10
    self.imageQREvent.clipsToBounds = true
    for obj in viewUpdateProfile.subviews {
      if obj is UITextField {
        let tf = obj as! UITextField
        
        tf.layer.masksToBounds = true
        tf.clearButtonMode = .always
        tf.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        tf.layer.borderColor = GeneralContants.colorWGGray.cgColor
        tf.layer.borderWidth = 1.0
        tf.layer.cornerRadius = 10
        tf.textColor = GeneralContants.colorWGGray
        
        tf.leftViewMode = UITextFieldViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 20, y: 0, width: 30, height: 30))
        
        switch tf.tag {
        case 0:
          let image = UIImage(named: "Name")
          imageView.image = image
        case 1:
          let image = UIImage(named: "invited")
          imageView.image = image;
        case 2:
          let image = UIImage(named: "roll")
          imageView.image = image;
        default:
          break
        }
        imageView.image = imageView.image!.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = GeneralContants.colorWGGray
        imageView.contentMode = .center
        tf.leftView = imageView;
        
      }
    }
    
    
  }
  
  
  
  @objc func keyboardWillShow(notification: NSNotification) {
    print("keyboardWillShow")
  }
  @objc func endEditing() {
    self.view.endEditing(true)
  }
  @objc func keyboardWillHide(notification: NSNotification){
    print("keyboardWillHide")
  }
  
  func generateQRCode(from string: String) -> UIImage? {
    let data = string.data(using: String.Encoding.ascii)
    
    if let filter = CIFilter(name: "CIQRCodeGenerator") {
      filter.setValue(data, forKey: "inputMessage")
      let transform = CGAffineTransform(scaleX: 3, y: 3)
      
      if let output = filter.outputImage?.transformed(by: transform) {
        return UIImage(ciImage: output)
      }
    }
    
    return nil
  }
  func showCamera() {
    imagePicker =  UIImagePickerController()
    imagePicker.delegate = self
    imagePicker.sourceType = .camera
    present(imagePicker, animated: false, completion: nil)
  }
  func getInformation() {
    let userDF = UserDefaults.standard
    let data = userDF.value(forKey: "imageProfile") as?  Data
    labelName.text = userDF.value(forKey: "name") as? String
    labelInviteFor.text = "Invitado por \( userDF.value(forKey: "invitedFor") as? String ?? "")"
    labelRoll.text = "Roll \(userDF.value(forKey: "roll") as? String ?? "")"
    guard data != nil else { return }
    image = UIImage(data: data!)!
    imgProfile.image = image
    imgProfile.contentMode = .scaleAspectFit
    textFieldName.text = userDF.value(forKey: "name") as? String
    textFieldInvite.text = userDF.value(forKey: "invitedFor") as? String
    textFieldRoll.text = userDF.value(forKey: "roll") as? String
    
  }
  func updateInformation() -> Bool {
    for obj in self.viewUpdateProfile.subviews {
      if obj is UITextField {
        let tf = obj as! UITextField
        if  tf.text == "" {
          let alert = UIAlertController(title: "Aviso", message: "Ningun campo debe estar vacio", preferredStyle: .alert)
          let action = UIAlertAction(title: "Entiendo", style: .default, handler: nil)
          alert.addAction(action)
          //          present(alert, animated: true, completion: nil)
          return false
        }
      }
    }
    let userDF = UserDefaults.standard
    userDF.set(textFieldName.text, forKey: "name")
    userDF.set(textFieldInvite.text, forKey: "invitedFor")
    userDF.set(textFieldRoll.text, forKey: "roll")
    let data = UIImagePNGRepresentation(image)
    userDF.set(data, forKey: "imageProfile")
    userDF.synchronize()
    getInformation()
    return true
  }
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func buttonUpdateProfile(_ sender: Any) {
    if constraintUpdateProfileAnimationY.constant == 97 {
      constraintUpdateProfileAnimationY.constant = viewProfile.frame.height
      UIView.animate(withDuration: 0.5) {
        self.tabBarController?.tabBar.isHidden = true
        self.view.layer.layoutIfNeeded()
      }
      self.btnEditProfileImage.isHidden = false
      self.imageQREvent.isHidden = true
      for obj in viewProfile.subviews {
        if obj is UILabel {
          if !(obj.tag == 1) {
            obj.isHidden = true
          }
        }
      }
    } else {
      if updateInformation() {
        self.btnEditProfileImage.isHidden = true
        self.imageQREvent.isHidden = false
        for obj in viewProfile.subviews {
          if obj is UILabel {
            obj.isHidden = false
          }
        }
        constraintUpdateProfileAnimationY.constant = 97
        UIView.animate(withDuration: 0.5) {
          self.tabBarController?.tabBar.isHidden = false
          self.view.layer.layoutIfNeeded()
        }
      } else {
        for obj in viewUpdateProfile.subviews {
          if obj is UITextField {
            let tf = obj as! UITextField
            if tf.text == "" {
              tf.layer.borderColor = UIColor.red.cgColor
              UIView.animate(withDuration: 0.3, animations: {
                obj.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 16)
              }, completion: { (Bool) in
                UIView.animate(withDuration: 0.3, animations: {
                  obj.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 16)
                }, completion: { (Bool) in
                  UIView.animate(withDuration: 0.3, animations: {
                    obj.transform = CGAffineTransform(rotationAngle: 0)
                    
                  })
                })
              })
            }
            tf.layer.borderColor = GeneralContants.colorWGGray.cgColor
          }
        }
      }
    }
  }
  
  @IBAction func editImageProfile(_ sender: Any) {
    let sheet = UIAlertController(title: "WeddingGram", message: "", preferredStyle: .actionSheet)
    let actionTakePhoto = UIAlertAction(title: "Tomar una Foto", style: .default) { (UIAlertAction) in
      self.showCamera()
    }
    let actionViewPhoto = UIAlertAction(title: "Ver Foto", style: .default) { (UIAlertAction) in
      
    }
    let cancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
    sheet.addAction(actionViewPhoto)
    sheet.addAction(actionTakePhoto)
    sheet.addAction(cancel)
    present(sheet, animated: true, completion: nil)
    
  }
  
}

extension ProfileDetailVC: PhotoEditorDelegate {
  
  func doneEditing(image: UIImage) {
    
    self.imgProfile.image = image
    
  }
  
  func canceledEditing() {
    print("Canceled")
  }
}

extension ProfileDetailVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    self.imgProfile.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    self.image = (info[UIImagePickerControllerOriginalImage] as? UIImage)!
    
    
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


