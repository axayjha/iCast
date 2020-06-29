//
//  Parser.swift
//  iCast
//
//  Created by Akshay Anand on 29/06/20.
//

import Foundation

class Parser {
    
    func getPostcastMetaData(data: Data) -> String? {
        let xml = SWXMLHash.parse(data)
        // print(xml["rss"]["channel"]["title"].element?.text)
        return xml["rss"]["channel"]["title"].element?.text
    }
}
