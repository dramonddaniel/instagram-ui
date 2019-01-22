//
//  Helpers.swift
//  instagram
//
//  Created by Daniel Dramond on 17/01/2019.
//  Copyright © 2019 Daniel Dramond. All rights reserved.
//

import UIKit

extension Date {
    func timeAgoDisplay() -> String {
        let secondsAgo = Int(Date().timeIntervalSince(self))
        
        if secondsAgo < 60 {
            return "Just now"
        } else if secondsAgo < 120 {
            return "\(secondsAgo / 60)m"
        } else if secondsAgo < 60 * 60 {
            return "\(secondsAgo / 60)m"
        } else if secondsAgo < 60 * 60 * 2 {
            return "\(secondsAgo / 60 / 60)h"
        } else if secondsAgo < 60 * 60 * 24 {
            return "\(secondsAgo / 60 / 60)h"
        } else if secondsAgo < 60 * 60 * 24 * 2 {
            return "\(secondsAgo / 60 / 60 / 24)d"
        } else if secondsAgo < 60 * 60 * 24 * 7 {
            return "\(secondsAgo / 60 / 60 / 24)d"
        } else if secondsAgo < 60 * 60 * 24 * 7 * 2 {
            return "\(secondsAgo / 60 / 60 / 24 / 7)w"
        } else if secondsAgo < 60 * 60 * 24 * 7 * 4 {
            return "\(secondsAgo / 60 / 60 / 24 / 7)w"
        }
        
        return "\(secondsAgo / 60 / 60 / 24 / 7) weeks ago"
    }
}

extension String {
    
    func estimatedFrame(_ view: UIView, _ minus: CGFloat, _ font: UIFont) -> CGRect {
        let size = CGSize(width: (view.frame.width) - minus, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: self).boundingRect(with: size, options: options, attributes: [kCTFontAttributeName as NSAttributedString.Key: font], context: nil)
    }
}

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BaseCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIColor {
    
    static func getHexColor(_ hex: String) -> UIColor {
        var hexString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if hexString.hasPrefix("#") { hexString.remove(at: hexString.startIndex) }
        if hexString.count != 6 { return UIColor.black }
        var rgb: UInt32 = 0
        Scanner(string: hexString).scanHexInt32(&rgb)
        return UIColor.init(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
                            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
                            blue: CGFloat((rgb & 0x0000FF)) / 255.0, alpha: 1.0)
    }
}

extension UIView {
    
    func handleEstimatedFrame(_ text: String, _ minus: CGFloat, font: UIFont) -> CGRect {
        let size = CGSize(width: self.frame.width - (minus), height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [kCTFontAttributeName as NSAttributedString.Key: font], context: nil)
    }
    
    func centerXY(_ view: UIView, x: CGFloat, y: CGFloat, _ centerX: NSLayoutXAxisAnchor? = nil, _ centerY: NSLayoutYAxisAnchor? = nil) -> [NSLayoutConstraint] {
        
        translatesAutoresizingMaskIntoConstraints = false
        var anchors = [NSLayoutConstraint]()
        
        if let centerX = centerX { anchors.append(centerX.constraint(equalTo: view.centerXAnchor, constant: x)) }
        if let centerY = centerY { anchors.append(centerY.constraint(equalTo: view.centerYAnchor, constant: y)) }
        
        anchors.forEach({$0.isActive = true})
        
        return anchors
    }
    
    func anchor(_ top: NSLayoutYAxisAnchor? = nil, _ right: NSLayoutXAxisAnchor? = nil, _ bottom: NSLayoutYAxisAnchor? = nil, _ left: NSLayoutXAxisAnchor? = nil, _ topConstant: CGFloat = 0, _ rightConstant: CGFloat = 0, _ bottomConstant: CGFloat = 0, _ leftConstant: CGFloat = 0, width: CGFloat = 0, height: CGFloat = 0) -> [NSLayoutConstraint] {
        
        translatesAutoresizingMaskIntoConstraints = false
        var anchors = [NSLayoutConstraint]()
        
        if let top = top { anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant)) }
        if let right = right { anchors.append(rightAnchor.constraint(equalTo: right, constant: -rightConstant)) }
        if let bottom = bottom { anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant)) }
        if let left = left { anchors.append(leftAnchor.constraint(equalTo: left, constant: leftConstant)) }
        if width > 0 { anchors.append(widthAnchor.constraint(equalToConstant: width)) }
        if height > 0 { anchors.append(heightAnchor.constraint(equalToConstant: height)) }
        
        anchors.forEach({$0.isActive = true})
        
        return anchors
    }
}

let imageCache = NSCache<NSString, UIImage>()

class CustomImageView: UIImageView {
    
    var imageUrlString: String?
    
    func loadImageUsingCacheWithUrlString(_ urlString: String) {
        
        imageUrlString = urlString
        
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            self.image = cachedImage
            return
        }
        
        self.image = nil
        
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            
            if error != nil { return }
            
            DispatchQueue.main.async {
                
                if let downloadedImage = UIImage(data: data!) {
                    
                    if self.imageUrlString == urlString {
                        if self.imageUrlString != "" {
                            self.image = downloadedImage
                        } else {
                            self.image = nil
                        }
                    }
                    
                    imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                }
            }
            
        }).resume()
    }
}
