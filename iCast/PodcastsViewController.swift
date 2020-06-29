//
//  PodcastsViewController.swift
//  iCast
//
//  Created by Akshay Anand on 29/06/20.
//

import Cocoa

class PodcastsViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {
    
    @IBOutlet weak var podcastURLTextField: NSTextField!
    
    var podcasts : [Podcast] = []
    
    @IBOutlet weak var tableView: NSTableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        podcastURLTextField.stringValue = "https://www.espn.com/espnradio/podcast/feeds/itunes/podCast?id=2406595"
        
        getPodcasts()
    }
    
    func getPodcasts() {
        if let context = (NSApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            let pods = Podcast.fetchRequest() as NSFetchRequest<Podcast>
            pods.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
            do {
                podcasts = try context.fetch(pods)

            } catch {}
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
        
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
                        let  info = parser.getPostcastMetaData(data: data!);
                        print(info)
                        DispatchQueue.main.async {
                            if let context = (NSApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                                let podcast = Podcast(context: context)
                                podcast.rssURL = self.podcastURLTextField.stringValue
                                podcast.imageURL = info.imageURL!
                                podcast.title = info.title!
                                (NSApplication.shared.delegate as? AppDelegate)?.saveAction(nil)
                                self.getPodcasts()
                            }
                        }
                    }
                }
            }.resume()
            
            podcastURLTextField.stringValue = ""
        }
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return podcasts.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "podcastCell"), owner: self) as? NSTableCellView
        let podcast = podcasts[row]
        if podcast.title != nil {
            cell?.textField?.stringValue = podcast.title!
        } else {
            cell?.textField?.stringValue = "UNKNOWN TITLE"
        }
        
        return cell
        
    }
}
