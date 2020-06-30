//
//  Episode.swift
//  iCast
//
//  Created by Akshay Anand on 30/06/20.
//

import Cocoa

class Episode {
    var title = ""
    var htmlDescription = ""
    var audioURL = ""
    var pubDate = Date()
    
    static let formatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss zzz"
            return formatter
    }()

}

