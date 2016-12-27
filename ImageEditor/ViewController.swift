//
//  ViewController.swift
//  ImageEditor
//
//  Created by jochem toolenaar on 27/12/2016.
//  Copyright © 2016 unbroken. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var croppButton: UIButton!
    @IBOutlet weak var previewImage: UIImageView!
    var cropView:CropView?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.\
        setupScrollViewEditing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupScrollViewEditing(){
        let vWidth = self.view.frame.width
        let vHeight = 210
        
        if let image = UIImage(named: "beach.jpg"){
            
            cropView = CropView(frame: CGRect(x:0, y:0, width:Int(vWidth), height:vHeight), image: image)
            self.view.addSubview(cropView!)
        }
        
    }
    
    @IBAction func onCropPressed(_ sender: Any) {
        if let cropView = self.cropView{
            if(cropView.isHidden){
                cropView.isHidden = false
                previewImage.isHidden = true
                croppButton.setTitle("crop", for: UIControlState.normal)
            }else{
                
                cropView.isHidden = true
                previewImage.isHidden = false
                previewImage.image = cropView.cropImage()
                croppButton.setTitle("reset", for: UIControlState.normal)
                
            }
        }
       
    }

}

