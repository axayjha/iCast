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
    var episodesVC: EpisodesViewController? = nil;

    
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
                        DispatchQueue.main.async {
                            if !self.podcastExists(rssURL: self.podcastURLTextField.stringValue) {
                                
                                
                                
                                
                                if let context = (NSApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                                    let podcast = Podcast(context: context)
                                    podcast.rssURL = self.podcastURLTextField.stringValue
                                    podcast.imageURL = info.imageURL!
                                    podcast.title = info.title!
                                    (NSApplication.shared.delegate as? AppDelegate)?.saveAction(nil)
                                    self.getPodcasts()
                                    self.podcastURLTextField.stringValue = ""
                                }
                            }
                        }
                        
                    }
                }
            }.resume()
            
            
        }
    }
    
    func podcastExists(rssURL: String) -> Bool {
        var result = false;
        
        if let context = (NSApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            let pods = Podcast.fetchRequest() as NSFetchRequest<Podcast>
            pods.predicate = NSPredicate(format: "rssURL == %@", rssURL)
            
            do {
                let matchingPodcasts = try context.fetch(pods)
                if matchingPodcasts.count >= 1 {
                    result = true
                }
                
            } catch {}
            
            
        }
        
        return result
        
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
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        if tableView.selectedRow >= 0 {
            let podcast = podcasts[tableView.selectedRow]
            
            episodesVC?.podcast = podcast
            episodesVC?.updateView()
            
        }
    }
}
