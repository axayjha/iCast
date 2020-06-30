//
//  TheSplitViewController.swift
//  iCast
//
//  Created by Akshay Anand on 30/06/20.
//

import Cocoa

class TheSplitViewController: NSSplitViewController {

    @IBOutlet weak var podcastsItem: NSSplitViewItem!
    @IBOutlet weak var episodesItem: NSSplitViewItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        if let podcastsVC = podcastsItem.viewController as? PodcastsViewController {
            if let episodesVC = episodesItem.viewController as? EpisodesViewController {
                podcastsVC.episodesVC = episodesVC
                episodesVC.podcastsVC = podcastsVC
            }
        }
    }
    
}
