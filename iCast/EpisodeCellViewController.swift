//
//  EpisodeCellViewController.swift
//  iCast
//
//  Created by Akshay Anand on 30/06/20.
//

import Cocoa
import WebKit

class EpisodeCellViewController: NSTableCellView{

    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var pubDateLabel: NSTextField!
    @IBOutlet weak var descriptionWebView: WKWebView!
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
}
