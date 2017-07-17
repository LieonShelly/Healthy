//
//  LReleaseSpaceViewController.swift
//  Healthy
//
//  Created by Liang on 17/6/26.
//  Copyright © 2017年 Healthy. All rights reserved.
//

import UIKit
import TZImagePickerController

class LReleaseSpaceViewController: UIViewController, TZImagePickerControllerDelegate {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var imageBGView: UIView!
    @IBOutlet weak var addImageButton: UIButton!
    
    @IBOutlet weak var releaseButton: UIButton!
    var imagePickerVC: TZImagePickerController! = nil
    var myImages: Array<UIImage> = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
        self.loadImages(images: [])
        self.setupImagePickerVC()
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupImagePickerVC() {
        self.imagePickerVC = TZImagePickerController.init(maxImagesCount: 9, delegate: self)
        self.imagePickerVC .allowPickingGif = false
    }
    
    func setupViews()  {
        
        self.releaseButton.layer.cornerRadius = 10
        self.releaseButton.layer.masksToBounds = true
        self.releaseButton.layer.shadowColor = UIColor.gray.cgColor
        self.releaseButton.layer.shadowOffset = CGSize.init(width: 2, height: 2)
        self.releaseButton.layer.shadowOpacity = 0.7
        self.releaseButton.backgroundColor = LColor
        
//        self.imageBGView.frame = CGRect.init(x: 16, y: 210, width: screenWidth - 32, height: 64)
//        
//        self.addImageButton.frame = CGRect.init(x: 2, y: 2, width: 60, height: 60)
    }
    
    func loadImages(images: Array<UIImage>) {
        
        for imageView in self.imageBGView.subviews {
            if imageView.tag == 99 {
                continue
            }
            imageView.removeFromSuperview()
        }
        
        for i in 0 ..< images.count {
            let imageButtonView = UIButton.init(frame: CGRect.init(x: 62 * (i % 4) + 2, y: 62 * (i / 4) + 2, width: 60, height: 60))
            self.imageBGView.addSubview(imageButtonView)
            
            imageButtonView.setBackgroundImage(images[i], for: .normal)
            imageButtonView.addTarget(self, action: #selector(self.addButtonAction(_:)), for: .touchUpInside)
        }
        
        self.imageBGView.frame = CGRect.init(x: 16, y: 210, width: Int(screenWidth - 32), height: 64 + 62 * Int(images.count / 4))
        self.addImageButton.frame = CGRect.init(x: 62 * (images.count % 4) + 2, y: 62 * (images.count / 4) + 2, width: 60, height: 60)
       
       
        
    }
    
    @IBAction func addButtonAction(_ sender: UIButton) {
        
        self.present(self.imagePickerVC, animated: true, completion: nil)
    }

    @IBAction func releaseButtonAction(_ sender: UIButton) {
        LFTPConnect.share.showList(path: "/")
//        LFTPConnect.share.uploadImages(images: self.myImages)
    }
    
    func imagePickerController(_ picker: TZImagePickerController!, didFinishPickingPhotos photos: [UIImage]!, sourceAssets assets: [Any]!, isSelectOriginalPhoto: Bool) {
        
        print("photo imageCount\(photos.count)")
        
//        self.myImages.removeAll()
        self.myImages = photos
        self.loadImages(images: photos)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.textView.resignFirstResponder()
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
