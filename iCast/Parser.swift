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
    
    func getEpisodes(data: Data) -> [Episode] {
        let xml = SWXMLHash.parse(data)
        // print(xml)
        // print(xml["rss"]["channel"]["item"] )
        
        var episodes : [Episode] = []
        
        for i in 0..<xml["rss"]["channel"]["item"].all.count {
            let episode = Episode()
            if let title = xml["rss"]["channel"]["item"][i]["title"].element?.text {
                episode.title = title
            }
            if let htmlDescription = xml["rss"]["channel"]["item"][i]["description"].element?.text {
                episode.htmlDescription = htmlDescription
            }
            
//            if let audioURL = xml["rss"]["channel"]["item"][i]["link"].element?.text {
//                episode.audioURL = audioURL
//            }
            
            if let audioURL = xml["rss"]["channel"]["item"][i]["enclosure"].element?.attribute(by: "url")?.text {
                episode.audioURL = audioURL
            }
            
            if let pubDate = xml["rss"]["channel"]["item"][i]["pubDate"].element?.text {                
                if let date = Episode.formatter.date(from: pubDate) {
                    episode.pubDate = date
                }
            }
            episodes.append(episode)
            //print(xml["rss"]["channel"]["item"][i]["title"])
            //print(episode.pubDate)
        }
        return episodes
    }
}
