//
//  PageManga.swift
//  MangaApp
//
//  Created by Phung buu quang on 12/14/17.
//  Copyright © 2017 Phung buu quang. All rights reserved.
//

import Foundation

struct PageManga {
    var chapterNumb: Int
    var imhLink: String = "https:monmichael.xyz/ios/404.jpg"
    
    init?(data: [Any]) {
        guard let chapterNumb = data[0] as? Int else {return nil}
        self.chapterNumb = chapterNumb
        
        if let imgItemLink = data[1] as? String{
            self.imhLink = "\(hostImgLink)\(imgItemLink)"
        }
    }
}
