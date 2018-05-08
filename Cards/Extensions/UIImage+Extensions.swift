//
//  UIImage+Extensions.swift
//  Cards
//
//  Created by Vincent Coetzee on 2018/04/02.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

extension UIImage
    {
    func resizedTo(size targetSize: CGSize) -> UIImage {
    let image = self
    let size = image.size

    let widthRatio  = targetSize.width  / size.width
    let heightRatio = targetSize.height / size.height

    // Figure out what our orientation is, and use that to form the rectangle
    var newSize: CGSize
    if(widthRatio > heightRatio) {
        newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
    } else {
        newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
    }

    // This is the rect that we've calculated out and this is what is actually used below
    let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

    // Actually do the resizing to the rect using the ImageContext stuff
    UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
    image.draw(in: rect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    return newImage!
}

    func inverted() -> UIImage? {
        guard let cgImage = self.cgImage else { return nil }
        let ciImage = CoreImage.CIImage(cgImage: cgImage)
        guard let filter = CIFilter(name: "CIColorInvert") else { return nil }
        filter.setDefaults()
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        let context = CIContext(options: nil)
        guard let outputImage = filter.outputImage else { return nil }
        guard let outputImageCopy = context.createCGImage(outputImage, from: outputImage.extent) else { return nil }
        return UIImage(cgImage: outputImageCopy)
    }
    
    func maskWith(mask maskImage:UIImage) -> UIImage?
        {
        guard let mask = maskImage.cgImage else
            {
            return(nil)
            }
        guard let imageMask = CGImage(  maskWidth: mask.width,height: mask.height,bitsPerComponent: mask.bitsPerComponent,bitsPerPixel: mask.bitsPerPixel,bytesPerRow: mask.bytesPerRow,provider: mask.dataProvider!, decode: nil, shouldInterpolate: false) else
            {
            return(nil)
            }
        guard let maskedImage = self.cgImage!.masking(imageMask) else
            {
            return(nil)
            }
        return(UIImage(cgImage:maskedImage))
    }
}
