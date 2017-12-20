//
//  MangaCollectionViewCell.swift
//  MangaApp
//
//  Created by Phung buu quang on 12/12/17.
//  Copyright © 2017 Phung buu quang. All rights reserved.
//

import UIKit
import Kingfisher

let cache: NSCache = NSCache<AnyObject, AnyObject>()

class MangaCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    func updateView(manga: Manga){
        nameLabel.text = manga.title
        let imgPlace = UIImage(named: "placeholderImg")
        guard let url = URL(string: manga.imgLink) else {return}

        if let img = cache.object(forKey: manga.imgLink as AnyObject) as? UIImage{
            self.imgView.image = img
        }else{
            self.imgView.image = nil
            imgView.kf.setImage(with: url, placeholder: imgPlace, options: nil, progressBlock: nil, completionHandler: nil)
            
//            DispatchQueue.global().async {
//                guard let imgData = try? Data(contentsOf: url) else {return}
//                guard let img = UIImage(data: imgData) else {return}
//
//                DispatchQueue.main.async {
//                    self.imgView.image = img
//                     cache.setObject(img, forKey: manga.imgLink as AnyObject)
//                }
//            }
        }
        
       
    }
}
