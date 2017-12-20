//
//  MangaPageViewController.swift
//  MangaApp
//
//  Created by Phung buu quang on 12/14/17.
//  Copyright © 2017 Phung buu quang. All rights reserved.
//

import UIKit
import Alamofire

class MangaPageViewController: UIViewController {

    @IBOutlet weak var pageCollectionView: UICollectionView!
    //var imgMangaPage = UIImageView()
    var id: String?
    var pageImgList: [PageManga] = [PageManga]()
    var limit: Int?
    var page: Int? = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataPageView()
        pageCollectionView.dataSource = self
        
        if let flowlayout = pageCollectionView.collectionViewLayout as? UICollectionViewFlowLayout{
            flowlayout.itemSize.width = screenWidth
            flowlayout.itemSize.height = screeHeight
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
        

    }
    
    func getDataPageView(){
        let urlString = "\(apiIdChapter)\(id!)"
        Alamofire.request(urlString).responseJSON { (response) in
            if let resultData = response.result.value as? JSONData{
                if let dataImg = resultData["images"] as? [[Any]]{
                    for dataDetailImg in dataImg{
                        if let data = PageManga(data: dataDetailImg){
                            self.pageImgList.append(data)
                            self.pageImgList.sort(by: {$0.chapterNumb < $1.chapterNumb})
                            print(self.pageImgList)
                            
                        }
                    }
                    self.pageCollectionView.reloadData()
                }
            }
        }
    }

}


extension MangaPageViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pageImgList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "pageCollectionCell", for: indexPath) as! PageMangaCollectionViewCell
        let data = pageImgList[indexPath.item]
        let url = URL(string: data.imhLink)
        let imgPlace = UIImage(named: "placeholderImg")
        collectionCell.imgPageView.kf.setImage(with: url, placeholder: imgPlace, options: nil, progressBlock: nil, completionHandler: nil)
        
        return collectionCell
    }
    
    
}





