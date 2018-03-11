//
//  GifManager.swift
//  Floater
//
//  Created by Chris Dean on 2018-03-11.
//  Copyright © 2018 Chris Dean. All rights reserved.
//

import Foundation
import UIKit
import Gifu

class GifManager: NSObject {
    
    @objc var imageView: GIFImageView!
    
    @objc func gifLoader(frame: CGRect) {
        imageView = GIFImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        //imageView.animate(withGIFData: data as Data)
        
    }
    
    @objc func gifAnimator(data: NSData) {
        imageView.animate(withGIFData: data as Data)
    }
    
}
