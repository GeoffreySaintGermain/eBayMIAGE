//
//  UIImage+extension.swift
//  eBayMIAGE
//
//  Created by SAINT GERMAIN on 06/12/2021.
//

extension UIImage {
    
    //MARK: Convenience function in UIImage extension to resize a given image
    
    func convert(toSize size:CGSize, scale:CGFloat) ->UIImage {
        let imgRect = CGRect(origin: CGPoint(x:0.0, y:0.0), size: size)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        self.draw(in: imgRect)
        let copied = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return copied!
    }
}
