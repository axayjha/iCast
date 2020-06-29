//
//  PodcastsViewController.swift
//  iCast
//
//  Created by Akshay Anand on 29/06/20.
//

import Cocoa

class PodcastsViewController: NSViewController {
    
    @IBOutlet weak var podcastURLTextField: NSTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        podcastURLTextField.stringValue = "https://www.espn.com/espnradio/podcast/feeds/itunes/podCast?id=2406595"
    }
    
    @IBAction func addPodcastClicked(_ sender: Any) {
        if let url = URL(string: podcastURLTextField.stringValue) {
            // print("URL: \(podcastURLTextField.stringValue)")
            URLSession.shared.dataTask(with: url) {
                (data: Data?, response: URLResponse?, error: Error?) in
                
                if error != nil {
                    print(error)
                } else {
                    if data != nil {
                        let parser = Parser()
                        if let title = parser.getPostcastMetaData(data: data!) {
                            print(title)
                        }
                    }
                }
            }.resume()
            
            podcastURLTextField.stringValue = ""
        }
    }
}
