//
//  PhotoCollectionViewController.swift
//  MemoryLane
//
//  Created by Kevin Chen on 12/28/16.
//  Copyright © 2016 Kevin Chen. All rights reserved.
//

import UIKit
import Photos
import PhotosUI

final class PhotoCollectionViewController: UICollectionViewController
{
    var photoAssets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView?.reloadData()
          
    }
}

private extension PhotoCollectionViewController {
    func photoForIndexPath(indexPath: IndexPath) -> PHAsset {
        return photoAssets[indexPath.row]
    }
}

extension PhotoCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return photoAssets.count
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell",
                                                      for: indexPath) as! PhotoCollectionCell
        
        let photoManager = PHImageManager.default()

        if cell.tag != 0 {
            photoManager.cancelImageRequest(PHImageRequestID(cell.tag))
        }
        
        let asset = photoAssets[indexPath.row]
        
        cell.photoImageView.tag = Int(photoManager.requestImage(for: asset, targetSize: CGSize(width: 25.0, height:25.0), contentMode: PHImageContentMode.default, options: nil, resultHandler: { (result, _) in
            cell.photoImageView.image = result
        }))
        
        return cell
    }
}
