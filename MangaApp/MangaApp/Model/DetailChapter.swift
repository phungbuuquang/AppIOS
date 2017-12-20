//
//  DetailChapter.swift
//  MangaApp
//
//  Created by Phung buu quang on 12/14/17.
//  Copyright © 2017 Phung buu quang. All rights reserved.
//

import Foundation
import UIKit

struct DetailChapter {
    var chapterNumb: Int
    var chapterDate: Int
    var chapterId: String
    
    init?(data: [Any]){
        guard let chapterNumb = data[0] as? Int else {return nil}
        self.chapterNumb = chapterNumb
        
        guard let chapterDate = data[1] as? Int else {return nil}
        self.chapterDate = chapterDate
        
        guard let chapterId = data[3] as? String else {return nil}
        self.chapterId = chapterId
    }
}
