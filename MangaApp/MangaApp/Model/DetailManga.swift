//
//  DetailManga.swift
//  MangaApp
//
//  Created by Phung buu quang on 12/13/17.
//  Copyright © 2017 Phung buu quang. All rights reserved.
//

import Foundation

struct DetailManga {
    var imgManga: String = "https:monmichael.xyz/ios/404.jpg"
    var nameManga: String
    var author: String = ""
    var dateRelease: Int
    var chapter: Int
    var category: String = "the loai"
    var description: String
    
    init?(data: JSONData){
        guard let nameManga = data["title"] as? String else {return nil}
        self.nameManga = nameManga
        
        guard let author = data["author"] as? String else {return nil}
        self.author = author
        
        guard let date = data["created"] as? Int else {return nil}
        self.dateRelease = date
        
        guard let chapter = data["chapters_len"] as? Int else {return nil}
        self.chapter = chapter
        
        if let categories = data["categories"] as? [String] {
            for cateItem in categories {
                self.category = cateItem
            }
        }
        if let imgManga = data["image"] as? String {
            self.imgManga = "\(hostImgLink)\(imgManga)"
        }
        guard let descript = data["description"] as? String else {return nil}
            self.description = descript
        
    }
}
