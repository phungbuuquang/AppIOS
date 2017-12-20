//
//  DetailMangaViewController.swift
//  MangaApp
//
//  Created by Phung buu quang on 12/13/17.
//  Copyright © 2017 Phung buu quang. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher



//let cache1: NSCache = NSCache<AnyObject, AnyObject>()

class DetailMangaViewController: UIViewController{

    // tham chiếu tất các các phần tử hiện thị trong mainStoryboard vào file code
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameMangaLbl: UILabel!
    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var chapterLbl: UILabel!
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var desLbl: UILabel!
    @IBOutlet weak var desView: UIScrollView!
    
    var DetailChapterList: [DetailChapter] = [DetailChapter]()
    var id:String?
    var detail: DetailManga?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none
        getDataDetail()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }
    
    //lấy data từ api
    func getDataDetail(){
        let urlString = "\(apiChapter)\(id!)"
        Alamofire.request(urlString).responseJSON { (response) in
            if let resultData = response.result.value as? JSONData{
                let data = DetailManga(data: resultData)
                self.updateView(data: data!)
                
                if let dataChapter = resultData["chapters"] as? [[Any]]{
                    for dataDetailChapter in dataChapter{
                        if let data = DetailChapter(data: dataDetailChapter){
                            self.DetailChapterList.append(data)
                            
                            // sắp xếp lại mảng theo thứ tự từ lớn tới nhỏ
                            self.DetailChapterList.sort(by: {$0.chapterNumb < $1.chapterNumb})
                        }
                    }
                    self.tableView.reloadData()
                }
            }
            
        }
    }
    
    // hiện thị nội dung ra view khi đã có data
    func updateView(data: DetailManga){
        self.nameMangaLbl.text = data.nameManga
        
        self.authorLbl.text = data.author
        
        let date = Date(timeIntervalSinceReferenceDate: TimeInterval((data.dateRelease)))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        self.dateLbl.text = dateFormatter.string(from: date)
        
        self.chapterLbl.text = "\(data.chapter )"
        
        self.categoryLbl.text = data.category
        
        let urlImg = data.imgManga
        let url = URL(string: urlImg)
        let imgPlace = UIImage(named: "placeholderImg")
            self.imgView.image = nil
            self.imgView.kf.setImage(with: url, placeholder: imgPlace, options: nil, progressBlock: nil, completionHandler: nil)
        
        let des = data.description
        self.desLbl.text = des
    }
    
    // gán func cho button segment
    @IBAction func segmentPress(_ sender: Any) {
        if segmentControl.selectedSegmentIndex == 0 {
            desView.isHidden = false
            tableView.isHidden = true
            
        }else if segmentControl.selectedSegmentIndex == 1 {
            tableView.isHidden = false
            desView.isHidden = true
        }
        
    }
}

// setup tableview
extension DetailMangaViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DetailChapterList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTable", for: indexPath) as! ChapterTableViewCell
        let dataChapter = DetailChapterList[indexPath.row]
        cell.chapterLbl.text = "Chapter \(dataChapter.chapterNumb)"
        
        let date = Date(timeIntervalSinceReferenceDate: TimeInterval((dataChapter.chapterDate)))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        cell.dateLbl.text = dateFormatter.string(from: date)
        
        return cell
    }
}
// gán sự kiện khi click vào mỗi cell
extension DetailMangaViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let pageVC = sb.instantiateViewController(withIdentifier: "mangaPage") as! MangaPageViewController
        let idChapter = DetailChapterList[indexPath.row].chapterId
        pageVC.id = idChapter
        self.navigationController?.pushViewController(pageVC, animated: true)
        print("next page")
    }
}
