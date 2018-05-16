//
//  TutorialVC.swift
//  Wedding
//
//  Created by Alberto Josue Gonzalez Juarez on 15/05/18.
//  Copyright © 2018 Alberto Josue Gonzalez Juarez. All rights reserved.
//

import UIKit

class TutorialVC: UIViewController {
  
  @IBOutlet weak var tutorialCollectionView: UICollectionView!
  @IBOutlet weak var tutorialPageControl: UIPageControl!
  @IBOutlet weak var skipButton: UIButton!
  
  @IBOutlet weak var nextButton: UIButton!
  var arrImage = [String]()
  override func viewDidLoad() {
    super.viewDidLoad()
    tutorialCollectionView.delegate = self
    tutorialCollectionView.dataSource = self
    tutorialCollectionView.isPagingEnabled = true
    tutorialCollectionView.clipsToBounds = true
    arrImage.append("feed")
    arrImage.append("map")
    arrImage.append("mesa de regalos")
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
  @IBAction func nextItem(_ sender: Any) {
    let cellSize = view.frame.size
    
    //get current content Offset of the Collection view
    let contentOffset = tutorialCollectionView.contentOffset
    
    if tutorialCollectionView.contentSize.width <= tutorialCollectionView.contentOffset.x + cellSize.width
    {
      let r = CGRect(x: 0, y: contentOffset.y, width: cellSize.width, height: cellSize.height)
      tutorialCollectionView.scrollRectToVisible(r, animated: true)
      
    } else {
      let r = CGRect(x: contentOffset.x + cellSize.width, y: contentOffset.y, width: cellSize.width, height: cellSize.height)
      tutorialCollectionView.scrollRectToVisible(r, animated: true);
    }
  }
  @IBAction func skipButton(_ sender: Any) {
    let userDF = UserDefaults.standard
    userDF.setValue(1, forKey: "isTutorial")
    self.dismiss(animated: true, completion: nil)
  }
  
}
extension TutorialVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return arrImage.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "TutorialCollectionCell", for: indexPath) as! TutorialCollectionCell
    cell.imageTutorial.image = UIImage(named: arrImage[indexPath.row])
    return cell
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
  {
    return CGSize(width : collectionView.frame.size.width, height : collectionView.frame.size.height)
  }
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    var visibleRect = CGRect()
    
    visibleRect.origin = tutorialCollectionView.contentOffset
    visibleRect.size = tutorialCollectionView.bounds.size
    
    let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
    
    guard let indexPath = tutorialCollectionView.indexPathForItem(at: visiblePoint) else { return }
    tutorialPageControl.currentPage = indexPath.row
  }
}
class TutorialCollectionCell: UICollectionViewCell {
  
  @IBOutlet weak var imageTutorial: UIImageView!
}
