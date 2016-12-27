//
//  CropView.swift
//  ImageEditorV
//
//  Created by jochem toolenaar on 27/12/2016.
//  Copyright © 2016 unbroken. All rights reserved.
//

import UIKit

class CropView: UIView {

    var imageView:UIImageView = UIImageView()
    var scrollView:UIScrollView = UIScrollView()
    var image:UIImage?
    
    init(frame: CGRect,image:UIImage) {
        super.init(frame: frame)
        self.image = image
        setupView();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView()
    {
        setupScrollview()
        setupImage()
    }
    
    func setupScrollview(){
        
        let vWidth = self.frame.width
        let vHeight = self.frame.height
        
        scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.frame = CGRect(x:0, y:0, width:Int(vWidth), height:Int(vHeight))
        scrollView.backgroundColor = UIColor.black
        scrollView.alwaysBounceVertical = false
        scrollView.alwaysBounceHorizontal = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.flashScrollIndicators()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        let minZoomScale = getMinimumZoomScale()
        self.scrollView.minimumZoomScale = minZoomScale
        
        scrollView.maximumZoomScale = 10.0
        self.addSubview(scrollView)
    }
    func setupImage(){
       
        if let image = self.image{
            
            scrollView.contentSize = CGSize(width: image.size.width, height: image.size.height)
            
            imageView = UIImageView(frame: CGRect(x: 0, y: 0, width:  image.size.width, height: image.size.height))
            imageView.image = image
            imageView.contentMode = .scaleAspectFill
            scrollView.addSubview(imageView)
            scrollView.zoomScale = getMinimumZoomScale()
        }
    }
    
    func getMinimumZoomScale() -> CGFloat{
        if let image = self.image{
            return min(self.scrollView.bounds.size.width / image.size.width, self.scrollView.bounds.size.height / image.size.height)
        }
        return 1
        
    }
    func getCropRect() -> CGRect{
        let scale = 1.0 / scrollView.zoomScale;
        
        var visibleRect = CGRect()
        visibleRect.origin.x = scrollView.contentOffset.x * scale;
        visibleRect.origin.y = scrollView.contentOffset.y * scale;
        visibleRect.size.width = scrollView.bounds.size.width * scale;
        visibleRect.size.height = scrollView.bounds.size.height * scale;
        return visibleRect
    }
    
    func cropImage() -> UIImage{
        if let image = image{
            let imageRef = image.cgImage?.cropping(to: getCropRect())
            if let imageRef = imageRef{
                return  UIImage(cgImage: imageRef)
            }
            

        }
        return UIImage()
        
    }


}
extension CropView:UIScrollViewDelegate{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
}
