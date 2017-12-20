//
//  Manga.swift
//  MangaApp
//
//  Created by Phung buu quang on 12/12/17.
//  Copyright © 2017 Phung buu quang. All rights reserved.
//

import Foundation
import UIKit

struct Manga {
    var imgLink: String = "https:monmichael.xyz/ios/404.jpg"
    var id: String
    var alias: String
    var title: String
    var hits: Int = 0
    var lastDate: Date = Date()
    var category: [String] = [String]()
    var status: Int = 1
    
    init?(data: JSONData){
        guard let id = data["i"] as? String else {return nil}
        self.id = id
        
        guard let alias = data["a"] as? String else {return nil}
        self.alias = alias
        
        guard let title = data["t"] as? String else {return nil}
        self.title  = title
        
        if let hits = data["h"] as? Int {
            self.hits = hits
        }
        
        if let lastDateInterval = data["ld"] as? TimeInterval {
            self.lastDate = Date(timeIntervalSince1970: lastDateInterval)
        }
        
        if let category = data["c"] as? [String]{
            self.category = category
        }
        
        if let status = data["s"] as? Int {
            self.status = status
        }
        if let imgLink = data["im"] as? String{
            self.imgLink = "\(hostImgLink)\(imgLink)"
        }
    }
    
}
