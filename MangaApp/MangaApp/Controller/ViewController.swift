//
//  ViewController.swift
//  MangaApp
//
//  Created by Phung buu quang on 12/12/17.
//  Copyright © 2017 Phung buu quang. All rights reserved.
//

import UIKit
import Alamofire



class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var mangaList: [Manga] = [Manga]()
    var refresh = UIRefreshControl()
    typealias JSONData = [String: Any]
    var page = 0
    let limit = 30
    var isFirstLoad = true
    var isLoading = false
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.addSubview(refresh)
        collectionView.delegate = self
        
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
        navigationItem.title = "Manga App"
       
        // xác định kích thước của collectionview cell
        if isFirstLoad{
            
            if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout{
                if screenWidth > 375{
                    flowLayout.itemSize.width = (screenWidth - 40)/3
                    flowLayout.itemSize.height = (screeHeight - 50)/4
                }else{
                    flowLayout.itemSize.width = (screenWidth - 30)/2
                    flowLayout.itemSize.height = (screeHeight - 40)/3
                }
                
            }
            
             getData()
            isFirstLoad = false
        }

    }
    
    // lấy dữ liệu từ api
    func getData(){
        let urlString = "\(apiEngDomain)?p=\(page)&l=\(limit)"
        Alamofire.request(urlString, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            if let resultData = response.result.value as? JSONData{
                if let mangaDataList = resultData["manga"] as? [JSONData]{
                    print(mangaDataList.count)
                    for mangaInfo in mangaDataList{
                        if let manga = Manga(data: mangaInfo) {
                              self.mangaList.append(manga)
                    }
                }
                self.collectionView.reloadData()
            }
        }
    }
    
    }
    
    // lấy dữ liệu từ api đổ vào trang kế tiếp
    func dataForNextPage(){
            isLoading = true
            page += 1
            let urlString = "\(apiEngDomain)?p=\(page)&l=\(limit)"
            Alamofire.request(urlString, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                if let resultData = response.result.value as? JSONData{
                    if let mangaDataList = resultData["manga"] as? [JSONData]{
                        print(mangaDataList.count)
                        for mangaInfo in mangaDataList{
                            if let manga = Manga(data: mangaInfo) {
                                self.mangaList.append(manga)
                                
                            }
                        }
                        self.collectionView.reloadData()
                    }
                }
                self.isLoading = false
            }
    }

}

// hiển thị nội dung ra collectionview
extension ViewController: UICollectionViewDataSource{


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mangaList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! MangaCollectionViewCell
       let mangaData = mangaList[indexPath.item]
       collectionCell.updateView(manga: mangaData)
        return collectionCell
    }
}

//set sự kiện khi cho collectionview
extension ViewController: UICollectionViewDelegate{
    // setup cho scrollview
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if refresh.isRefreshing{
            page = 0
            getData()
            refresh.endRefreshing()
        }
        if isLoading {return}
        let offsetY = scrollView.contentOffset.y
        let contentHeght = scrollView.contentSize.height
        if contentHeght - offsetY - scrollView.bounds.size.height <= 1 {
            dataForNextPage()
        }
    }
    // setup event cho collectionview cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("did select")
        let id = mangaList[indexPath.item].id
        print("id: ",id)
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = sb.instantiateViewController(withIdentifier: "DetailManga") as! DetailMangaViewController
        detailVC.id = id
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

