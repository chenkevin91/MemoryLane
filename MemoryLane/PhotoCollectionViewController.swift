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
        
        //var photoAssets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
        
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

        let asset = photoAssets[indexPath.row]
        
        cell.photoImageView.tag = Int(photoManager.requestImage(for: asset, targetSize: CGSize(width: 100.0, height: 100.0), contentMode: PHImageContentMode.aspectFit, options: nil, resultHandler: { (result, _) in
            cell.photoImageView.image = result
        }))
        
        cell.photoImageView.contentMode = .scaleToFill
        
        return cell
    }
}
