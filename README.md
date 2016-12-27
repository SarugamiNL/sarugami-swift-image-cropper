# sarugami swift image cropper
Here an example of doing some easy image cropping using a scrollview, allowing to position and zoom the image.

All functionality is found in the CropView.swift file. Just copy the file paste it into your project and create a CropView like this :

```swift
if let image = UIImage(named: "myImage.jpg"){
            
   let cropView = CropView(frame: CGRect(x:0, y:0, width:width, height:height), image: image)
   self.view.addSubview(cropView!)
}
```

To crop the image just call the cropImage() method on the CropView

```swift
let croppedImage = cropView.cropImage()
```
