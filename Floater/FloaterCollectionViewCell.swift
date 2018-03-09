//
//  FloaterCollectionViewCell.swift
//  Floater
//
//  Created by Chris Dean on 2018-03-08.
//  Copyright © 2018 Chris Dean. All rights reserved.
//

import UIKit

class FloaterCollectionViewCell: UICollectionViewCell {
  
    @IBOutlet var floaterView: UIImageView!
    @objc var downloadTask = URLSessionDownloadTask()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        downloadTask.cancel()
        floaterView.image = nil
    }
}
