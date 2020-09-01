//
//  UIImageExtension.swift
//  ZuYu2
//
//  Created by million on 2020/8/20.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit

func drawCircle(diameter: CGFloat, color: UIColor) -> UIImage? {
    UIGraphicsBeginImageContextWithOptions(CGSize(width: diameter, height: diameter), false, 0.0)
    let ctx = UIGraphicsGetCurrentContext()!
    ctx.saveGState()
    ctx.setFillColor(color.cgColor)
    let rect = CGRect(x: 0, y: 0, width: diameter, height: diameter)
    ctx.fillEllipse(in: rect)
    ctx.restoreGState()
    let image = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return image
}

func textToImage(text: String, image: UIImage, rect: CGRect) -> UIImage? {
    
    // initialize new image with source image
    let scale = UIScreen.main.scale
    UIGraphicsBeginImageContextWithOptions(image.size, false, scale)
    image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
    
    // set limits on text area and find matching font
    let padding = 0.075 * rect.size.width
    let textWidth = rect.size.width - 2 * padding
    
    // use a UIFont extension to find the optimal font for the given size constraints
    // e.g. https://qiita.com/cayozin/items/f574fa803eeeb6b3310a
    let font = UIFont.systemFont(ofSize: 10)
    
    // find the equivalent size in pixels and use the text height to center it in the circle
    let size = (text as NSString).size(withAttributes: [NSAttributedString.Key.font : font])
    let xOffset = padding
    let yOffset = 0.5 * rect.size.height - 0.5 * size.height
    let rect = CGRect(
        origin: CGPoint(x: rect.origin.x + xOffset, y: rect.origin.y + yOffset),
        size: CGSize(width: textWidth, height: font.lineHeight)
    )
    
    // define properties of the text to be drawn
    let textColor = UIColor.white
    let paragraph = NSMutableParagraphStyle()
    paragraph.alignment = .center
    let textFontAttributes : [NSAttributedString.Key : Any] = [
        .font: font,
        .paragraphStyle: paragraph,
        .foregroundColor: textColor,
        ]
    text.draw(in: rect, withAttributes: textFontAttributes)
    
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage
}

extension UIImage {
    func redDotImage(_ iconOffset : CGPoint = CGPoint(x: 0.8, y: 0.0), _ text: String = "") ->UIImage {//define the badge as half the size of the original image, and located in the top-right corner
        let iconSizeFraction: CGFloat = 6.0/34.0
        
        let diameter: CGFloat = iconSizeFraction * size.width
        let iconSize = CGSize(width: diameter, height: diameter)
        
        // define the new size of the original image
        let newSize = CGSize(
            width: max(size.width, iconOffset.x + iconSize.width) - min(0.0, iconOffset.x),
            height: max(size.height, iconOffset.y + iconSize.height) - min(0.0, iconOffset.y)
        )
        
        // start drawing
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        let context = UIGraphicsGetCurrentContext()!
        context.saveGState()
        
        // put the origin of the coordinate system at the top left
        if let cgImage = cgImage {
            context.translateBy(x: 0, y: size.height)
            context.scaleBy(x: 1.0, y: -1.0)
            let rect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
            context.draw(cgImage, in: rect)
        }
        context.restoreGState()
        
        // define the rectangle in which the badge should be drawn
        let badgeRect = CGRect(
            x: size.width * iconOffset.x,
            y: size.height * iconOffset.y,
            width: iconSize.width,
            height: iconSize.height
        )
        
        // draw the red badge circle
        if let circle = drawCircle(diameter: diameter, color: UIColor.red)?.cgImage {
            context.draw(circle, in: badgeRect)
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // add the label to this new image
        if let imageWIthText = textToImage(
            text: text,
            image: image,
            rect: badgeRect) { return imageWIthText }
        return image
    }
    
}
