//
//  TicketReaderVC.swift
//  Wedding
//
//  Created by RanfeDom on 11/22/17.
//  Copyright © 2017 Alberto Josue Gonzalez Juarez. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

class TicketReaderCV: ViewController {
  var videoCaptureDevice = AVCaptureDevice.default(for: AVMediaType.video)
  var device = AVCaptureDevice.default(for: AVMediaType.video)

  var output = AVCaptureMetadataOutput()
  var previewLayer: AVCaptureVideoPreviewLayer?
  
  var captureSession = AVCaptureSession()
  var code: String?
  
  var scannedCode = UILabel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCamera()
    addLabelForDisplayingCode()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if !captureSession.isRunning {
      captureSession.startRunning()
    }
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    if captureSession.isRunning {
      captureSession.stopRunning()
    }
  }
  
  fileprivate func setupCamera() {
    guard let videoCaptureDevice = videoCaptureDevice else { return }
    guard let input = try? AVCaptureDeviceInput(device: videoCaptureDevice) else { return }
    
    if self.captureSession.canAddInput(input) {
      self.captureSession.addInput(input)
    }
    
    self.previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    
    if let videoPreviewLayer = self.previewLayer {
      videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
      videoPreviewLayer.frame = self.view.bounds
      view.layer.addSublayer(videoPreviewLayer)
    }
    
    let metadataOutput = AVCaptureMetadataOutput()
    if self.captureSession.canAddOutput(metadataOutput) {
      self.captureSession.addOutput(metadataOutput)
      
      metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
      metadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
      
    } else {
      print("Could not add metadata output")
    }
  }
  
  fileprivate func addLabelForDisplayingCode() {
    view.addSubview(scannedCode)
    scannedCode.translatesAutoresizingMaskIntoConstraints = false
    scannedCode.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20.0).isActive = true
    scannedCode.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0).isActive = true
    scannedCode.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0).isActive = true
    scannedCode.heightAnchor.constraint(equalToConstant: 50).isActive = true
    scannedCode.font = UIFont.preferredFont(forTextStyle: .title2)
    scannedCode.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    scannedCode.textAlignment = .center
    scannedCode.textColor = UIColor.white
    scannedCode.text = "Scanning...."
  }
  
}

extension TicketReaderCV: AVCaptureMetadataOutputObjectsDelegate {
  func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
    print(metadataObjects)
    for metadata in metadataObjects {
      let readableObject = metadata as! AVMetadataMachineReadableCodeObject
      let code = readableObject.stringValue
      scannedCode.text = code
    }
  }
}
