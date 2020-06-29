//
//  Parser.swift
//  iCast
//
//  Created by Akshay Anand on 29/06/20.
//

import Foundation

class Parser {
    
    func getPostcastMetaData(data: Data) -> (title: String?, imageURL: String?) {
        let xml = SWXMLHash.parse(data)
        // print(xml["rss"]["channel"]["title"].element?.text)
        let imageURL = xml["rss"]["channel"]["itunes:image"].element?.attribute(by: "href")?.text
        let title = xml["rss"]["channel"]["title"].element?.text
        return (title, imageURL)
    }
}
